class CreateRooms < ActiveRecord::Migration[7.0]
  def change
    create_table :rooms do |t|
      t.text :name
      t.text :describe

      t.timestamps
    end
  end
end
