class AddRealnameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :realname, :string
  end
end
