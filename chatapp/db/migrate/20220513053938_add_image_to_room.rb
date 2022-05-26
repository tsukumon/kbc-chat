class AddImageToRoom < ActiveRecord::Migration[7.0]
  def change
    add_column :rooms, :image, :text
  end
end
