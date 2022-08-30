class AddAdminToRoom < ActiveRecord::Migration[7.0]
  def change
    add_column :rooms, :admin, :integer
  end
end
