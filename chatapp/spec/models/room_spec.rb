require 'rails_helper'

RSpec.describe Room, type: :model do
  #pending "add some examples to (or delete) #{__FILE__}"
  describe '.abbreviated_name' do
    it 'ルーム名が返ること' do
      articles = Room.new(name: 'test-room1')
      expect(article.abbreviated_title).to eq 'ルーム名です'
    end
  end

  describe '.publish' do
    
  end
end
