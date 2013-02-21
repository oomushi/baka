class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.integer :user_id
      t.string :type
      t.string :value

      t.timestamps
    end
  end
end
