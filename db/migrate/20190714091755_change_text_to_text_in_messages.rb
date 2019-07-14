class ChangeTextToTextInMessages < ActiveRecord::Migration[5.2]
  def up
    change_column :messages, :text, :text
  end
  def down
    change_column :messages, :text, :string
  end
end
