class Room < ApplicationRecord
  validates :name, {presence: true, length: {maximum: 30}}
  validates :describe, {presence: true, length: {maximum: 400}}
  validates :image, presence: true
  mount_uploader :image, RoomUploader
end
