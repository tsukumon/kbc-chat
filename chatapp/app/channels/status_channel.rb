class StatusChannel < ApplicationCable::Channel
  def subscribed
    stream_from "status_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
    if count_connection?(current_user.id)
      ActionCable.server.broadcast "status_channel", {user_id: current_user.id, status: "offline"}
      @user = User.find_by(id: params[:user_id])
      @user.update(status: false)  
    end
  end

  def appear
    ActionCable.server.broadcast "status_channel", {user_id: current_user.id, status: "online"}
    @user = User.find_by(id: params[:user_id])
    @user.update(status: true)
  end

  def count_connection?(current_user)
    users_id = ActionCable.server.open_connections_statistics.map { |con| con[:subscriptions].map { |sub| JSON.parse(sub)["user_id"] } }.flatten
    !users_id.any?{ |user| user.to_i == current_user }
  end
end
