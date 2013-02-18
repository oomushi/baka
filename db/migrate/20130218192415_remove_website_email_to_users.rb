class RemoveWebsiteEmailToUsers < ActiveRecord::Migration
  def up
    remove_column :users, :email
    remove_column :users, :website
  end

  def down
    add_column :users, :email, :string, :null=>false
    add_column :users, :website, :string
  end
end
