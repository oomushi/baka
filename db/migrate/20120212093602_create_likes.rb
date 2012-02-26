class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.integer :user_id
      t.integer :message_id
      t.integer :value,:default=>0

      t.timestamps
    end
    add_index :likes, [:user_id, :message_id],:unique=>true
  end
end
