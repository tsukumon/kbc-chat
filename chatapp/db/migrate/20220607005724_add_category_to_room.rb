class AddCategoryToRoom < ActiveRecord::Migration[7.0]
  def change
    add_column :rooms, :category, :string
  end
end
