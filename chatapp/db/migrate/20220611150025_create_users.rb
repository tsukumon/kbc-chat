class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.text :name
      t.text :email
      t.text :image
      t.text :oauth_token
      t.datetime :oauth_expires_at

      t.timestamps
    end
  end
end
