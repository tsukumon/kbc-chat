class HomeController < ApplicationController
    def index
        @rooms = Room.all
    end

    def get

    end

    def create
        @message = Message.new(sentence: params[:message], room_id: params[:id])
    end
end
