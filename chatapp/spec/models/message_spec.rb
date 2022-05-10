require 'rails_helper'

RSpec.describe Message, type: :model do
  describe "GET index" do
    before do
      @message = create(:message)
    end

    it "response HTTP 200" do
      get message_path
      expect(response).to be_successfull
    end
  
  end

  describe "message post action" do
    it "redirect to " do
      post message_path, :params => {:sentence => "test-message"}
      expect(response).to redirect_to message_path
    end
  end

  describe "m" do

  end

  
  #pending "add some examples to (or delete) #{__FILE__}"


end
