class ChangeTextToTextInMessages < ActiveRecord::Migration[5.2]
  def up
    change_column :messages, :text, :text, null: false
  end
  def down
    change_column :messages, :text, :string, null: false
  end
end
