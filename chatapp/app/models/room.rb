class Room < ApplicationRecord
  has_and_belongs_to_many :message, dependent: :destroy
  has_many :rooms_user, dependent: :destroy
  has_many :user, through: :rooms_user
  mount_uploader :image, RoomUploader

  #VALID_CATEGORY = /\AQ&A\z|\A募集\z|\A雑談\z|\Aプログラミング\z|\AOS\z|\Aクラウド\z/
  validates :name, {presence: true, length: {maximum: 30}}
  validates :describe, {length: {maximum: 400}}
  validates :category, {presence: true, length: {maximum: 15}}
  
  scope :by_category_like, lambda { |category|
  where('category LIKE :value', { value: "%#{sanitize_sql_like(category)}%"}).distinct.limit(5)
  }
  
  scope :by_name_like, lambda { |name|
  where('name LIKE :value', { value: "%#{sanitize_sql_like(name)}%"}).limit(5)
  }

  def join_admin(user)
    RoomsUser.create(room_id: self.id, user_id: user.id, admin: true)
  end

end
