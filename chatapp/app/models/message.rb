class Message < ApplicationRecord
    has_and_belongs_to_many :room
    validates :sentence, {presence: true, length: {maximum: 2000}}
    validates :user_id, presence: true
end
