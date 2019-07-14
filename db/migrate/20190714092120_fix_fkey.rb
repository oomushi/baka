class FixFkey < ActiveRecord::Migration[5.2]
  def up
    change_column :messages, :writer_id, :bigint
    change_column :messages, :reader_id, :bigint
    change_column :messages, :moderator_id, :bigint
    add_index :messages, :writer_id
    add_index :messages, :reader_id
    add_index :messages, :moderator_id
    add_foreign_key :messages, :groups, column: :writer_id
    add_foreign_key :messages, :groups, column: :reader_id
    add_foreign_key :messages, :groups, column: :moderator_id
  end
  def down
    remove_foreign_key :messages, column: :writer_id
    remove_foreign_key :messages, column: :reader_id
    remove_foreign_key :messages, column: :moderator_id
    add_foreign_key :messages, :groups, column: :writer_id
    add_foreign_key :messages, :groups, column: :reader_id
    add_foreign_key :messages, :groups, column: :moderator_id
    remove_index :messages, :writer_id
    remove_index :messages, :reader_id
    remove_index :messages, :moderator_id
    change_column :messages, :writer_id, :integer
    change_column :messages, :reader_id, :integer
    change_column :messages, :moderator_id, :integer
  end
end
