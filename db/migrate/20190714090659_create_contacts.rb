class CreateContacts < ActiveRecord::Migration[5.2]
  def change
    create_table :contacts do |t|
      t.references :user, foreign_key: true, null: false
      t.string :protocol, null: false
      t.string :value, null: false

      t.timestamps
    end
  end
end
