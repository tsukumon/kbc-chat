class MessageChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    stream_from "message_channel"
    user = User.find_by(id: current_user.id)
    puts user.name
    stream_for user
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
