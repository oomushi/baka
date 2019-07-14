class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.string :title
      t.string :text
      t.boolean :section
      t.boolean :pinned
      t.references :message, foreign_key: true
      t.references :user, foreign_key: true
      t.integer :nv
      t.integer :dv
      t.integer :snv
      t.integer :sdv
      t.boolean :follow
      t.integer :writer_id
      t.integer :reader_id
      t.integer :moderator_id

      t.timestamps
    end
  end
end
