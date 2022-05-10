class MessageController < ApplicationController
    def index
        @message = Message.where(room_id params[:id])
    end
    
    def new

    end

    def post
        @post = Message.new(room_id: params[:id], sentence: params[:msg])
        if @post.save
            redirect_to room_path(@post.room_id)
        else
            flash = "送信に失敗しました"
        end
    end
end
