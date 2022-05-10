class MessageController < ApplicationController

  def create
    @message = Message.new(room_id: params[:id], sentence: params[:sentence])
    if @message.save
      redirect_to "/room/#{@message.room_id}"
    end
  end
end
