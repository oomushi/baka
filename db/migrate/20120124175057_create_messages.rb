class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :text
      t.bool :section
      t.int :lft
      t.int :rgt
      t.string :title
      t.int :message_id
      t.int :user_id

      t.timestamps
    end
  end
end
