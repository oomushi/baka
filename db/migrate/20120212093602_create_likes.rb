class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.integer :user_id
      t.integer :message_id
      t.integer :value

      t.timestamps
    end
    add_index :likes, [:user_id, :message_id],:unique=>true
  end
end
