class RemovePasswordToUsers < ActiveRecord::Migration
  def up
    remove_column :users, :password_hash
    remove_column :users, :password_salt
    remove_column :users, :confirm_code
    remove_column :users, :realname
    remove_column :users, :guest
  end

  def down
    add_column :users, :realname, :string
    add_column :users, :confirm_code, :string
    add_column :users, :password_salt, :string
    add_column :users, :password_hash, :string
    add_column :users, :guest, :boolean, :default=>false
  end
end
