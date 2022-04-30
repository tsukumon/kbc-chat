class Room < ApplicationRecord
  validates :name, presence: true
  validates :describe, presence: true
end
