class RoomController < ApplicationController
  include MarkdownHelper
  include RoomHelper

  protect_from_forgery :except => [:create_message]
  before_action :authenticate_user
  before_action :authenticate_room, only: [:page, :create_message]
  
  def index
    @search = Room.ransack(params[:q])
    @results = @search.result.order(created_at: :DESC)
    @room = Room.all.order(created_at: :DESC).limit(5)
  end

  def join
    @room = Room.find_by(id: params[:id])
    user = User.find_by(id: @current_user.id)
    @room.user << user
    redirect_to room_page_path(id: params[:id])
  end

  def leave
    @room = Room.find_by(id: params[:id])
    user = User.find_by(id: @current_user.id)
    @room.user.delete(user)
    redirect_to room_path, status: :see_other
  end

  def authenticate_room
    unless UserRoom.find_by(user_id: @current_user.id, room_id: params[:id])
      redirect_to room_path
    end
  end


  def joined
    @rooms = UserRoom.where(user_id: @current_user.id).pluck(:room_id) #UserRoomテーブルのcurrent_userが参加してるroomのroom_idカラムだけ取る
    @room_info = Room.where(id: @rooms).includes(:message).order(updated_at: :DESC)
  end

  def page
    @room = Room.find_by(id: params[:id])
    @messages = Message.where(room_id: params[:id]).order(created_at: :DESC).page(params[:page]).per(30)
    @message = Message.new

    @members_id = UserRoom.where(room_id: params[:id]).pluck(:user_id)
    @members = User.where(id: @members_id)
    @members_hash = @members.map{ |user| [user.id, user.attributes]}.to_h
  end

  def new_room
    @room = Room.new
    @categories = Room.group(:category).select("category, count(category) as category_count").order("category_count desc").limit(10).map { |m| [m.category, m.category_count] }.to_h
  end

  def create_room
    @room = Room.new(room_params)
    now_user = User.find_by(id: @current_user.id)
    @room.user << now_user

    if @room.save
      redirect_to "/room/#{@room.id}", notice: t("messages.create.notice")
    else
      render "room/new_room", status: :unprocessable_entity, alert: t("messages.create.alert")
    end
  end

  def edit_room
    @room = Room.find_by(id: params[:id])
  end

  def update_room
    @room = Room.find_by(id: params[:id])
    @room.update(room_params)

    if @room.save
      redirect_to "/room/#{@room.id}"
    end
  end

  def destroy_room
    @room = Room.find_by(id: params[:id])
    if @room.destroy
      redirect_to room_path, status: :see_other
    end
  end

  def create_message
    @message = Message.new(message_params)
    if @message.save
      @time = date_format(@message.created_at)
      @message.sentence = markdown(@message.sentence)
      @user = User.find_by(id: @message.user_id)
      ActionCable.server.broadcast "message_#{params[:id]}_channel",{ content: @message, time: @time, mode: "create", current_user: @current_user.id, user: @user }
    end
  end

  def destroy_message
    @message = Message.find_by(id: params[:id])
    if @message.destroy
      ActionCable.server.broadcast "message_#{@message.room_id}_channel",{ content: @message, mode: "delete" }
    end
  end


  def autocomplete_category
    categories = Room.by_category_like(autocomplete_params[:category]).pluck(:category).reject(&:blank?)
    render json: categories
  end

  def autocomplete_name
    names = Room.by_name_like(autocomplete_params[:name]).pluck(:name).reject(&:blank?)
    render json: names
  end
  
  def search_result
    @search = Room.ransack(params[:q])
    @results = @search.result
  end

  def search_form
    @room = Room.all.order(created_at: :DESC).limit(5)
    @search = Room.ransack(params[:q])
    @results = @search.result
    category_select
  end

  def search_joined
    @search = Room.ransack(params[:q])
    @results = @search.result
  end

  private

  def autocomplete_params
    if params[:category]
      params.permit(:category)
    elsif params[:name]
      params.permit(:name)
    end
  end

  def room_params
    params.require(:room).permit(:name, :describe, :image, :category)
  end

  def message_params
    sentence = params.require(:message).permit(:sentence)
    ids = { "room_id" => params[:id], "user_id" => @current_user.id }
    return sentence.merge(ids)
  end

  def category_select
    @category_sel = Room.group(:category).order(count_all: :DESC).count
  end

end
