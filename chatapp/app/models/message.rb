class Message < ApplicationRecord
    validates :sentence, presence: true
    validates :room_id, presence: true
end
