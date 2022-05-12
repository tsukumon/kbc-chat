class MessageController < ApplicationController

  def create
    @message = Message.new(room_id: params[:id], sentence: params[:sentence])
    if @message.save
      ActionCable.server.broadcast 'message_channel', content: @message
    end
  end
end
