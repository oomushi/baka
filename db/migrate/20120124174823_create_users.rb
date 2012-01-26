class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :password
      t.date :birthday
      t.string :sign
      t.string :avatar,:default=>"/images/users/guest.png"

      t.timestamps
    end
    add_index :users,:username,:unique=>true
  end
end
