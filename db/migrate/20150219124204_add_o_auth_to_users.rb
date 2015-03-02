class AddOAuthToUsers < ActiveRecord::Migration
  def change
    add_column :users, :provider, :string
    add_column :users, :uid, :string, :null=>true
    add_column :users, :oauth_token, :string
    add_column :users, :oauth_expires_at, :datetime
    add_index :users, [:uid], :unique => true
  end
end
