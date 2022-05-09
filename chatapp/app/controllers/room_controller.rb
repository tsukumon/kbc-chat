class RoomController < ApplicationController

  def index
    @rooms = Room.all
  end

  #room新規作成ページ（GET）
  def new_room
    #code
  end

  #room新規作成処理（POST）
  def create_room
    @room = Room.new(
      name: params[:name],
      describe: params[:describe]
    )

    if @room.save
      redirect_to room_path
    end
  end

  def destroy_room
    @room = Room.find_by(id: params[:id])
    if @room
      @room.destroy
      redirect_to("/room")
    end
  end

end
