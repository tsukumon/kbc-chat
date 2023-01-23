class RoomsUser < ApplicationRecord
  belongs_to :room
  belongs_to :user

  def self.update_admin(room_id, user_ids)
    room_users = RoomsUser.where(room_id: room_id)
    room_users.update_all(admin: false)

    users = user_ids.reject { |v| v == "" }
    users.each do |user|
      room_user = RoomsUser.find_by(room_id: room_id, user_id: user.to_i)
      room_user.update(admin: true)
    end
  end
end