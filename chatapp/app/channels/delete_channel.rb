class DeleteChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def delete(data)
    ActionCable.server.broadcast 'delete_channel', id: data['id']
    message = Message.find_by(id: data['id'])
    message.destroy
  end
end
