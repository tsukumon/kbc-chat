class MessageChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    @user = User.find_by(id: params[:user_id])
    reject if @user.nil?
    @room = @user.room.find_by(id: params[:room_id])
    reject if @room.nil?
    stream_from "message_#{params[:room_id]}_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end