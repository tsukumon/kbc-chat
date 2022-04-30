class HomeController < ApplicationController
    def home
        @rooms = Room.all
    end
end
