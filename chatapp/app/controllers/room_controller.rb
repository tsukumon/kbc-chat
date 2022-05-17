class RoomController < ApplicationController
  #room新規作成ページ（GET）
  def new
    #code
  end

  #room新規作成処理（POST）
  def create
    @room = Room.new(name: params[:name], describe: params[:describe], image: params[:image])
    #@room.save  #=> if文の条件式で実行されるので不必要

    if @room.save
      redirect_to "/room/#{@room.id}"
    
    else
      flash[:alert] = "ルーム名か詳細情報が空白です"
      redirect_to "/room/new"

    end
  end

  def room_params
    params.require(:room).permit(:name, :describe, :image)
  end


  def index
    @rooms = Room.all
  end

  #ルームページ（個別)
  def page
    @room = Room.find_by(id: params[:id])
    @messages = Message.where(room_id: params[:id])
  end

  def destroy
    @room = Room.find_by(id: params[:id])
    if @room.destroy
      redirect_to room_path, status: :see_other
    end
  end

end
