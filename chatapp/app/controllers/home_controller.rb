class HomeController < ApplicationController
before_action :authenticate_user

    def index
        @rooms = Room.all.order(name: :asc)
    end
end
