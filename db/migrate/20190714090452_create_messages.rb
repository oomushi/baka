class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.string :title, null: false
      t.string :text, null: false
      t.boolean :section, default: false
      t.boolean :pinned, default: false
      t.references :message, foreign_key: true, null: false
      t.references :user, foreign_key: true, null: false
      t.integer :nv, default: 0, limit: 8
      t.integer :dv, default: 0, limit: 8
      t.integer :snv, default: 0, limit: 8
      t.integer :sdv, default: 0, limit: 8
      t.boolean :follow, default: true
      t.integer :writer_id, null: false, default: 1
      t.integer :reader_id, null: false, default: 1
      t.integer :moderator_id, null: false, default: 2

      t.timestamps
    end
  end
end
