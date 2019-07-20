class CreateChoices < ActiveRecord::Migration[5.2]
  def change
    create_table :choices do |t|
      t.string :text, null: false
      t.references :poll, foreign_key: true, null: false

      t.timestamps
    end
  end
end
