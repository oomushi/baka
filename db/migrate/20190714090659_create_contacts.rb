class CreateContacts < ActiveRecord::Migration[5.2]
  def change
    create_table :contacts do |t|
      t.references :user, foreign_key: true
      t.string :protocol
      t.string :value

      t.timestamps
    end
  end
end
