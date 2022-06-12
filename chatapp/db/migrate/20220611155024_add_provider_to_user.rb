class AddProviderToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :provider, :text
  end
end
