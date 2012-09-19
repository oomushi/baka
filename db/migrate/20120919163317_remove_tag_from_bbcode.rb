class RemoveTagFromBbcode < ActiveRecord::Migration
  def up
    remove_column :bbcodes, :tag
      end

  def down
    add_column :bbcodes, :tag, :string
  end
end
