class RoomController < ApplicationController
  include MarkdownHelper
  include RoomHelper

  protect_from_forgery :except => [:create_message]
  before_action :authenticate_user
  before_action :authenticate_room, only: [:page, :create_message]
  
  def index
    #@rooms = UserRoom.where(user_id: @current_user.id).pluck(:room_id)
    @user_data = User.find_by(id: @current_user.id)
    @room_all = Room.where(private: false).page(params[:room_page]).per(8)
    @room_latest = Room.where(private: false).order(created_at: :DESC).limit(4)
    @room_update = Room.where("created_at < updated_at", private: false)
                  .order(updated_at: :DESC).limit(4)

    #joined rooms
    @joined_rooms = @user_data.room
  end

  def join
    @room = Room.find_by(id: params[:id])
    user = User.find_by(id: @current_user.id)
    @room.user << user
    ActionCable.server.broadcast "message_#{params[:id]}_channel",{ mode: "join", current_user: @current_user.id, user: user }
    redirect_to room_page_path(id: params[:id])
  end

  def leave
    @room = Room.find_by(id: params[:id])
    user = User.find_by(id: @current_user.id)
    @room.user.delete(user)
    redirect_to "/room/joined", status: :see_other
  end

  def authenticate_room
    room = Room.find(params[:id])
    unless room.user.find_by(id: @current_user.id)
      redirect_to room_path
    end
  end

  def joined
    @user_data = User.find_by(id: @current_user.id)
    @room_info = @user_data.room.order(updated_at: :DESC)
    @invited_rooms = Room.where(id: @room_info.ids, private: true)
                    .where.not(admin: @current_user.id)
  end

  def page
    @room_data = Room.find_by(id: params[:id])
    @user_data = User.all
    @messages = Message.where(room_id: params[:id]).order(created_at: :DESC).page(params[:page]).per(30)
    @message = Message.new

    #modal room member list
    @admin = User.find_by(id: @room_data.admin)
    @info_members = @room_data.user

    #messages
    members_id = Message.where(room_id: params[:id]).pluck(:user_id)
    @members = User.where(id: members_id)
    @members_hash = @members.map{ |member| [member.id, member.attributes]}.to_h  
  end

  def edit_room
    @room = Room.find_by(id: params[:id])
  end

  def update_room
    @room = Room.find_by(id: params[:id])
    @room.update(room_params)

    if @room.save
      redirect_to "/room/#{@room.id}"
    else
      render(
        turbo_stream: turbo_stream.update(
          "errors-update-room",
          partial: "room/error_messages",
          locals: {
            model: @room
          }
        )
      )
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
      @room_data = Room.find_by(id: params[:id])
      @room_data.update(updated_at: Time.now)
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

  def autocomplete_name
    names = Room.by_name_like(autocomplete_params[:name]).pluck(:name).reject(&:blank?)
    render json: names
  end
  
  def search_result
    @search = Room.ransack(params[:q])
    @results = @search.result
    @user_data = User.find_by(id: @current_user.id)
    @joined_rooms = @user_data.room
    @public_rooms = Room.where(private: false)
    @invited_rooms = @joined_rooms.where(private: true)
  end

  def search_form
    @user_data = User.find_by(id: @current_user.id)
    @rooms = Room.where(private: false).order(created_at: :DESC).limit(12)
    @joined_rooms = @user_data.room
    @search = Room.ransack(params[:q])
    @results = @search.result
  end

  def autocomplete_category
    categories = Room.by_category_like(autocomplete_params[:category]).pluck(:category).reject(&:blank?)
    #categories = Room.by_name_like(autocomplete_params[:category]).pluck(:name).reject(&:blank?)
    render json: categories
  end
  
  private
  
  def autocomplete_params
    if params[:category]
      params.permit(:category)
    elsif params[:name]
      params.permit(:name)
    end
  end

  def message_params
    sentence = params.require(:message).permit(:sentence)
    ids = { "room_id" => params[:id], "user_id" => @current_user.id }
    return sentence.merge(ids)
  end

  def room_params
    params.require(:room).permit(:name, :describe, :image, :category, :private, { user_ids: [] })
  end
end
