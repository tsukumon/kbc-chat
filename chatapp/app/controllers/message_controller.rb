class MessageController < ApplicationController

  def create
    @message = Message.new(message_params)
    if @message.save
      if @message.created_at > 1.days.ago
        @time = "今日 #{@message.created_at.strftime("%H:%M")}"
      else
        @time = "#{@message.created_at.strftime("%Y/%m/%d")}"
      end
      ActionCable.server.broadcast "message_channel",{ content: @message, time: @time, mode: "create"}
    else
      render room_message_path(params[:id]), status: :unprocessable_entity
    end
  end

  def destroy
    @message = Message.find_by(id: params[:id])
    if @message.destroy
      ActionCable.server.broadcast "message_channel",{ content: @message, mode: "delete"}
    end
  end

  private

  def message_params
    sentence = params.require(:message).permit(:sentence)
    room_id = { "room_id"  => params[:id] }
    return sentence.merge(room_id)
  end
end
