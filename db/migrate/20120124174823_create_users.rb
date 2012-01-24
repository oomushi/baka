class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :password
      t.date :birthday
      t.string :sign
      t.string :avatar

      t.timestamps
    end
  end
end
