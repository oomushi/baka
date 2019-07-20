class CreatePolls < ActiveRecord::Migration[5.2]
  def change
    create_table :polls do |t|
      t.string :title, null: false
      t.references :message, foreign_key: true, null: false

      t.timestamps
    end
  end
end
