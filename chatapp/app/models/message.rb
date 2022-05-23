class Message < ApplicationRecord
    belongs_to :room
    validates :sentence, {presence: true, length: {maximum: 2000}}
    validates :room_id, presence: true
end
