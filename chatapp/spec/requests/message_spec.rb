require 'rails_helper'

RSpec.describe "Messages", type: :request do
  describe "GET /index" do
    before do
      @message = create(:message)
    end

    it "response HTTP 200" do
      get room_page_path
      expect(response).to be_successfull
    end

    #pending "add some examples (or delete) #{__FILE__}"
  end

  describe "redirect to room" do
    it "post and redirect room" do
      post "/message/1", :params => {:sentence => "test-message"}
      expect(response).to redirect_to "/room/1"
    end
  end

  describe "error empty sentense" do
    it "empty sentense" do
      post "/message/1", :params => {:sentence => ""}
      expect(response).to have_http_status "204"
    end

  end

  describe "delete messages" do
    it "delete sentense" do
      post "/message/1", :params => {:sentence => "test-message"}
      delete "/message/delete/1", :params => {:id => 1}
      expect(response).to redirect_to "/room/1"
    end
  end



end
