class Message < ApplicationRecord
    belongs_to :room
    has_many :user
    validates :sentence, {presence: true, length: {maximum: 2000}}
    validates :room_id, presence: true
    validates :user_id, presence: true
end
