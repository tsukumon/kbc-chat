require 'rails_helper'

RSpec.describe "Rooms", type: :request do
  describe "GET /index" do
    #pending "add some examples (or delete) #{__FILE__}"
  end

  describe "room create action" do
    #正常に新規作成が出来た場合
    #トップページにリダイレクト出来ているか
    it "新規制作出来た場合" do
      post room_create_path, :params => { :name => "room name", :describe => "room info datails" }
      expect(response).to redirect_to room_path
    end
    
    #正常に新規作成が出来なかった場合
    #HTTP204レスポンスが返ってきているか
    it "新規制作出来なかった場合" do
      post room_create_path, :params => { :name => "", :describe => "" }
      expect(response).to have_http_status "204"
    end
  end 

  describe "room destroy action" do
    before do 
      #モデルのみ作成
      @room = create(:room)
    end
    
    #正常に削除が出来た場合
    #トップページにリダイレクト出来ているか
    it "削除処理できる場合" do
      post room_destroy_id_path, :params => { :id => 1}
      expect(response).to redirect_to room_path
    end
    
    #正常に削除が出来なかった場合
    #HTTP204レスポンスが返ってきているか
    it "削除処理が出来なかった場合" do
      post room_destroy_id_path, :params => { :id => ""}
      expect(response).to have_http_status "204"
    end
  end 
end
