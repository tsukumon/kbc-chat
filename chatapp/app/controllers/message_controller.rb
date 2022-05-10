class MessageController < ApplicationController
    def new

    end

    def post
        @post = Message.new(sentence: params[:msg])
        if @post.save
            redirect_to
end
