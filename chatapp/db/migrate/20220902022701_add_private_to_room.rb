class AddPrivateToRoom < ActiveRecord::Migration[7.0]
  def change
    add_column :rooms, :private, :boolean, default: false, null: false
  end
end
