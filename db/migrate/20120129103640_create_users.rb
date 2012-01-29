class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username,:null=>false
      t.string :email,:null=>false
      t.string :password_hash
      t.string :password_salt
      t.string :confirm_code
      t.string :sign
      t.string :avatar,:default=>"/assets/users/guest.png"
      t.date :birthday

      t.timestamps
    end
    add_index :users,:username,:unique=>true
  end
end
