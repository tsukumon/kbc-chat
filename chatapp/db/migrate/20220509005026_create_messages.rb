class CreateMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :messages do |t|
      t.text :sentence
      t.integer :room_id

      t.timestamps
    end
  end
end
