class Message < ApplicationRecord
    has_and_belongs_to_many :room
    # belongs_to :room
    # belongs_to :user
    validates :sentence, {presence: true, length: {maximum: 2000}}
    #validates :room_id, presence: true
    validates :user_id, presence: true
end
