class RoomsUser < ApplicationRecord
  belongs_to :room
  belongs_to :user

  def self.update_admin(room_id, user_ids)
    room_users = RoomsUser.where(room_id: room_id)
    room_users.update_all(admin: false)

    users = user_ids.reject { |v| v == "" }
    # room_users = RoomsUser.where(room_id: room_id)
    # not_admin = RoomsUser.where(room_id: room_id).where(admin: true).where.not(user_id: users)

    users.each do |user|
      room_user = RoomsUser.find_by(room_id: room_id, user_id: user.to_i)
      room_user.update(admin: true)
    end

    # if not_admin.present?
    #   not_admin.each do |n|
    #     room_user = RoomsUser.find_by(room_id: n.room_id, user_id: n.user_id)
    #     room_user.update(admin: false)
    #   end
    # end
  end
end