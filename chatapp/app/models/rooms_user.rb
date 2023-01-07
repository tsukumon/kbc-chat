class RoomsUser < ApplicationRecord
  belongs_to :room
  belongs_to :user

  def self.add_admin(room_id, user_ids)
    users = user_ids.reject { |v| v == "" }
    users.each do |user|
      room_user = RoomsUser.find_by(room_id: room_id, user_id: user.to_i)
      room_user.update(admin: true)
    end
  end
  # def change_admin
  #   self.update(admin: true)
  # end
end