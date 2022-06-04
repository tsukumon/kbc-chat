class RoomController < ApplicationController
  protect_from_forgery :except => [:create_message]

  def index
    @rooms = Room.all.order(name: :asc)
  end

  def page
    @room = Room.find_by(id: params[:id])
    @messages = Message.where(room_id: params[:id]).order(created_at: :DESC)
    @message = Message.new
  end

  def new_room
    @room = Room.new
  end

  def create_room
    @room = Room.new(room_params)

    if @room.save
      redirect_to "/room/#{@room.id}", notice: t("messages.create.notice")
    else
      render "room/new_room", status: :unprocessable_entity, alert: t("messages.create.alert")
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
      if @message.created_at > 1.days.ago
        @time = "今日#{@message.created_at.strftime("%H:%M")}"
      else
        @time = "#{@message.created_at.strftime("%Y/%m/%d")}"
      end
      ActionCable.server.broadcast "message_channel",{ content: @message, time: @time, mode: "create" }
    end
  end

  def destroy_message
    @message = Message.find_by(id: params[:id])
    if @message.destroy
      ActionCable.server.broadcast "message_channel",{ content: @message, mode: "delete" }
    end
  end

  private

  def room_params
    params.require(:room).permit(:name, :describe, :image)
  end

  def message_params
    sentence = params.require(:message).permit(:sentence)
    room_id = { "room_id" => params[:id] }
    return sentence.merge(room_id)
  end

end
