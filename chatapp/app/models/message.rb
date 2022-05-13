class Message < ApplicationRecord
    validates :sentence, {presence: true, length: {maximum: 2000}}
    validates :room_id, presence: true
end
