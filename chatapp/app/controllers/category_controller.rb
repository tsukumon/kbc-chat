class CategoryController < ApplicationController
  def index
    @joined_rooms = UserRoom.where(user_id: @current_user.id).pluck(:room_id)
    @rooms = Room.where(id: @joined_rooms, category: params[:id])
    @rooms_hash = @rooms.map{ |room| [room.id, room.attributes]}.to_h
  end
end
