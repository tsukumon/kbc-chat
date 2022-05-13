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
end
