class RoomController < ApplicationController
  #room新規作成ページ（GET）
  def new
    #code
  end

  #room新規作成処理（POST）
  def create
    #code
  end
 
  #ルームページ（個別)
  def page
    @room = Room.find_by(id: params[:id])
    @messages = Message.find_by(room_id: params[:id])
  end

end
