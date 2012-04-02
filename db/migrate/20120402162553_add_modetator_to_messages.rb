class AddModetatorToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :writer_id, :integer
    add_column :messages, :reader_id, :integer
  end
end
