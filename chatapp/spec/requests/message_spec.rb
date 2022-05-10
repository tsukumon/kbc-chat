require 'rails_helper'

RSpec.describe "Messages", type: :request do
  describe "GET /index" do
    before do
      @message = post(:message)
    end

    it "response HTTP 200" do
      get message_path
      expect(response).to be_successfull
    end

    #pending "add some examples (or delete) #{__FILE__}"
  end

  describe "message post action" do
    it "redirect to " do
      post room_post_path, :params => {:sentence => "test-message"}
      expect(response).to redirect_to room_post_path
    end
  end

  describe "m" do

  end

end
