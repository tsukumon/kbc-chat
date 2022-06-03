class HomeController < ApplicationController
    def index
        @rooms = Room.all.order(name: :asc)
    end
end
