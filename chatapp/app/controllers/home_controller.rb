class HomeController < ApplicationController
    def index
        @rooms = Room.all
        @room_length = Room.count
    end
end
