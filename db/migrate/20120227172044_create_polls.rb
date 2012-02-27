class CreatePolls < ActiveRecord::Migration
  def change
    create_table :polls do |t|
      t.string :title,:null=>false
      t.integer :message_id,:null=>false

      t.timestamps
    end
  end
end
