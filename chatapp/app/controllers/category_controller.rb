class CategoryController < ApplicationController
  def all_category
    category = CGI.unescape(params[:category])
    @joined_rooms = UserRoom.where(user_id: @current_user.id).pluck(:room_id)
    @rooms_not_joined = Room.where.not(id: @joined_rooms)
    @rooms_all = @rooms_not_joined.where(category: category)
    @rooms_all_hash = @rooms_all.map{ |room| [room.id, room.attributes]}.to_h
  end

  def joined_category
    category = CGI.unescape(params[:category])
    @joined_rooms = UserRoom.where(user_id: @current_user.id).pluck(:room_id)
    @rooms = Room.where(id: @joined_rooms, category: category)
    @rooms_hash = @rooms.map{ |room| [room.id, room.attributes]}.to_h
  end
end
