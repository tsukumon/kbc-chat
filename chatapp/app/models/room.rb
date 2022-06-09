class Room < ApplicationRecord
  has_many :message, dependent: :destroy
  mount_uploader :image, RoomUploader

  #VALID_CATEGORY = /\AQ&A\z|\A募集\z|\A雑談\z|\Aプログラミング\z|\AOS\z|\Aクラウド\z/
  validates :name, {presence: true, length: {maximum: 30}}
  validates :describe, {length: {maximum: 400}}
  validates :category, {presence: true, length: {maximum: 15}}

  scope :by_category_like, lambda { |category|
  where('category LIKE :value', { value: "#{sanitize_sql_like(category)}%"})
  }

  scope :by_name_like, lambda { |name|
  where('name LIKE :value', { value: "%#{sanitize_sql_like(name)}%"})
  }
end
