class Room < ApplicationRecord
  has_many :message, dependent: :destroy
  validates :name, {presence: true, length: {maximum: 30}}
  validates :describe, {length: {maximum: 400}}
  VALID_CATEGORY = /\AQ&A\z|\A募集\z|\A雑談\z|\Aプログラミング\z|\AOS\z|\Aクラウド\z/
  validates :category, {presence: true, format: {with: VALID_CATEGORY}}
  mount_uploader :image, RoomUploader
end
