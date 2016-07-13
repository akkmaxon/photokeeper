class AddOmniauthToUsers < ActiveRecord::Migration
  def change
    add_column :users, :omni_provider, :string
    add_column :users, :omni_uid, :string
  end
end
