class RoomController < ApplicationController
  protect_from_forgery :except => [:create_message]
  before_action :search

  def index
    @q = Room.ransack(params[:q])
    @results = @q.result.order(created_at: :DESC)
  end

  def page
    @room = Room.find_by(id: params[:id])
    @messages = Message.where(room_id: params[:id]).order(created_at: :DESC)
    @mess = Message.page(params[:page]).per(5)
    @message = Message.new
  end

  def new_room
    @room = Room.new
    @categories = Room.group(:category).select("category, count(category) as category_count").order("category_count desc").limit(10).map { |m| [m.category, m.category_count] }.to_h
  end

  def create_room
    @room = Room.new(room_params)

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
      if @message.created_at >= Date.today.beginning_of_day
        @time = "今日#{@message.created_at.strftime("%H:%M")}"
      elsif @message.created_at < Date.today.beginning_of_day && @message.created_at >= Date.yesterday.beginning_of_day
        @time = "昨日#{@message.created_at.strftime("%H:%M")}"
      else
        @time = "#{@message.created_at.strftime("%Y/%m/%d")}"
      end
      @message.sentence = CGI.escapeHTML(@message.sentence).gsub(/\n|\r|\r\n/, "<br>")
      ActionCable.server.broadcast "message_channel",{ content: @message, time: @time, mode: "create" }
    end
  end

  def destroy_message
    @message = Message.find_by(id: params[:id])
    if @message.destroy
      ActionCable.server.broadcast "message_channel",{ content: @message, mode: "delete" }
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
  
  def search
    @q = Room.ransack(params[:q])
    @results = @q.result
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
    room_id = { "room_id" => params[:id] }
    return sentence.merge(room_id)
  end

end
