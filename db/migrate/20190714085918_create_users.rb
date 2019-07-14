class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :username
      t.string :sign
      t.date :birthday
      t.string :location

      t.timestamps
    end
  end
end
