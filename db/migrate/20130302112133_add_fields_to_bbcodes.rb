class AddFieldsToBbcodes < ActiveRecord::Migration
  def up
    add_column :bbcodes, :tag, :string, :null=>false, :default=>''
    add_column :bbcodes, :text, :string, :null=>false, :default=>''
    add_column :bbcodes, :singular, :boolean, :null=>false,:default=>true
    add_column :bbcodes, :match, :string, :null=>false, :default=>'.+'
  end
  def down
    remove_column :bbcodes, :tag
    remove_column :bbcodes, :text
    remove_column :bbcodes, :singular
    remove_column :bbcodes, :match
  end
end
