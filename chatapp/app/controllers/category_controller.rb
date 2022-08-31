class CategoryController < ApplicationController
  def index
    category = CGI.unescape(params[:category])
    @category_name = params[:category_name]
    @joined = UserRoom.where(user_id: @current_user.id).pluck(:room_id)
    @rooms = Room.where.not(id: @joined).where(category: category)
    @rooms_joined = Room.where(id: @joined, category: category)
  end
end
