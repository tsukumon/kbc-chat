class MessageController < ApplicationController

  def create
    @message = Message.new(room_id: params[:id], sentence: params[:sentence])
    if @message.save
      if @message.created_at > 1.days.ago
        @time = "今日 #{@message.created_at.strftime("%H:%M")}"
      else
        @time = "#{@message.created_at.strftime("%Y/%m/%d")}"
      end
      ActionCable.server.broadcast "message_channel",{ content: @message, time: @time}
    end
  end

  def destroy
    @room = Room.find_by(id: params[:room_id])
    @message = Message.find_by(id: params[:id])
    if @message
      @message.destroy
      ActionCable.server.broadcast "delete_channel", {id: @message.id}
    end
  end
end
