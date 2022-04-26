class HomeController < ApplicationController

    def home
        @room = Room.all
    end

    def rooms
    end
end
