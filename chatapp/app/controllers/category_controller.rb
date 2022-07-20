class CategoryController < ApplicationController
  def index
    category = CGI.unescape(params[:category])
    @joined_rooms = UserRoom.where(user_id: @current_user.id).pluck(:room_id)
    @rooms = Room.where(id: @joined_rooms, category: category)
    @rooms_hash = @rooms.map{ |room| [room.id, room.attributes]}.to_h
  end
end
