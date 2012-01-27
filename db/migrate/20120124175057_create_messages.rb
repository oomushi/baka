class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :text,:null=>false
      t.boolean :section,:default=>false
      t.boolean :pinned,:default=>false
      t.integer :lft,:null=>false
      t.integer :rgt,:null=>false
      t.string :title,:null=>false
      t.integer :message_id,:null=>false
      t.integer :user_id,:null=>false

      t.timestamps
    end
  end
end
