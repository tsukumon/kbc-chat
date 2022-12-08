class CategoryController < ApplicationController
  def index
    @user_data = User.find_by(id: @current_user.id)
    @category = CGI.unescape(params[:category])

    @rooms = Room.where(category: @category)
    @joined_rooms = @user_data.room
  end
end
