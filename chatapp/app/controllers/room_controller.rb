class RoomController < ApplicationController
  #room一覧表示
  def index
    @rooms = Room.all
  end

  #room新規作成ページ（GET）
  def new_room
    #code
    
  end

  #room新規作成処理（POST）
  def create_room
    #code
    @room = Room.new(name: params[:name], describe: params[:describe])
    if @room.save
      redirect_to room_path
    else
      flash= "作成に失敗しました"
      redirect_to room_new_path
    end
  end

end
