class ApplicationController < ActionController::Base
  before_action :set_current_user, :new_room

  def set_current_user
    @current_user = User.find_by(id: session[:user_id])
  end

  def authenticate_user
    if @current_user == nil
      redirect_to new_session_path
    end
  end
  
  def forbid_login_user
    if @current_user
      redirect_to root_path
    end
  end

  def new_room
    @new_room = Room.new
    @categories = Room.group(:category).select("category, count(category) as category_count").order("category_count desc").limit(5).map { |m| [m.category, m.category_count] }.to_h
  end

  def create_room
    @new_room = Room.new(room_params)
    @categories = Room.group(:category).select("category, count(category) as category_count").order("category_count desc").limit(10).map { |m| [m.category, m.category_count] }.to_h
    now_user = User.find_by(id: @current_user.id)
    @new_room.user << now_user

    if @new_room.save
      redirect_to "/room/#{@new_room.id}"
    else
      render "room/new_room", status: :unprocessable_entity
    end
  end

  private

  def room_params
    params.require(:room).permit(:name, :describe, :image, :category)
  end

end