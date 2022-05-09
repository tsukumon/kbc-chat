require 'rails_helper'

RSpec.describe Room, type: :model do
  #pending "add some examples to (or delete) #{__FILE__}"
  before do 
    #モデルのみ作成
    @room = create(:room)
  end

  describe 'バリデーション' do
    it 'nameとdescribeどちらも値が設定されていればOK' do
      expect(@room.valid?).to eq(true)
    end

    it 'nameが空だとNG' do
      @room.name = ''
      expect(@room.valid?).to eq(false)
    end

    it 'describeが空だとNG' do
      @room.describe = ''
      expect(@room.valid?).to eq(false)
    end
  end
end
