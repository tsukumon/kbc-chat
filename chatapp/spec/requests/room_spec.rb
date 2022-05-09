require 'rails_helper'

RSpec.describe "Rooms", type: :request do
  describe "GET /index" do
    #pending "add some examples (or delete) #{__FILE__}"
      before do
        @room = create(:room)
      end
  
      it "HTTP200が帰ってくるか" do
        get room_new_path
        expect(response).to be_successfull
      end
  
  
  end

  describe "room create action" do
    it "redirects the page to room_path" do
      post room_create_path, :params => { :name => "room name", :describe => "room info datails" }
      expect(response).to redirect_to room_path
    end

    it "redirects the page to new_path" do
      post room_create_path, :params => { :name => "", :describe => "room info datails" }
      expect(response).to have_http_status "204"
    end
  end

end
