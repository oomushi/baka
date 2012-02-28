class CreatePollOptionsUsers < ActiveRecord::Migration
  def change
    create_table :poll_options_users,:id=>false do |t|
      t.integer :user_id,:null=>false
      t.integer :poll_option_id,:null=>false
    end
    add_index :poll_options_users,[:user_id,:poll_option_id],:unique=>true
  end
end
