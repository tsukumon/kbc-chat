class Room < ApplicationRecord
  has_many :message, dependent: :destroy
  validates :name, {presence: true, length: {maximum: 30}}
  validates :describe, {length: {maximum: 400}}
  validates :category, presence: true
  mount_uploader :image, RoomUploader
end
