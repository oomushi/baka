class RemoveFieldsToBbcodes < ActiveRecord::Migration
  def up
    remove_column :bbcodes, :layout
    remove_column :bbcodes, :value
    remove_column :bbcodes, :inner
    remove_column :bbcodes, :properties
  end

  def down
    add_column :bbcodes, :properties, :integer
    add_column :bbcodes, :inner, :string
    add_column :bbcodes, :value, :string
    add_column :bbcodes, :layout, :string
  end
end
