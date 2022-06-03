class RoomController < ApplicationController
  #room新規作成ページ（GET）
  def new
    @room = Room.new
  end

  #room新規作成処理（POST）
  def create
    @room = Room.new(room_params)

    if @room.save
      redirect_to "/room/#{@room.id}", notice: t("messages.create.notice")
    
    else
      render room_new_path, status: :unprocessable_entity, alert: t("messages.create.alert")
    end
  end

  def index
    @rooms = Room.all.order(name: :asc)
  end

  #ルームページ（個別)
  def page
    @room = Room.find_by(id: params[:id])
    @messages = Message.where(room_id: params[:id]).order(created_at: :DESC)
  end

  def destroy
    @room = Room.find_by(id: params[:id])
    if @room.destroy
      redirect_to room_path, status: :see_other
    end
  end

  private

  def room_params
    params.require(:room).permit(:name, :describe, :image)
  end

end
