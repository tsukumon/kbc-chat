class Room < ApplicationRecord
  has_many :message, dependent: :destroy
  has_many :user_room, dependent: :destroy
  has_many :user, through: :user_room
  mount_uploader :image, RoomUploader

  #VALID_CATEGORY = /\AQ&A\z|\A募集\z|\A雑談\z|\Aプログラミング\z|\AOS\z|\Aクラウド\z/
  validates :name, {presence: true, length: {maximum: 30}}
  validates :describe, {length: {maximum: 400}}
  validates :category, {presence: true, length: {maximum: 15}}
  validates :admin, {presence: true}

  scope :by_category_like, lambda { |category|
  where('category LIKE :value', { value: "#{sanitize_sql_like(category)}%"}).distinct
  }

  scope :by_name_like, lambda { |name|
  where('name LIKE :value', { value: "%#{sanitize_sql_like(name)}%"}).limit(5)
  }
end
