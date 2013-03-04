class AddFieldsToBbcodes < ActiveRecord::Migration
  def up
    add_column :bbcodes, :tag, :string, :null=>false, :default=>''
    add_column :bbcodes, :text, :string, :null=>false, :default=>''
    add_column :bbcodes, :singular, :boolean, :null=>false,:default=>true
    add_column :bbcodes, :match, :string, :null=>false, :default=>'.+'
    Bbcode.all.each do |b|
      if b.output =~ /^\[(:.)/
        b.tag=''
        b.output=$1
        b.label=$1
      else
        b.tag=b.label
        value=b.value.gsub('?','#{meta}')
        value<<b.inner.gsub('?','#{content}')
        b.text=b.layout.gsub('?',value)
      end
      b.match='.+'
      b.singular=!(b.properties&16).zero?
      b.save
    end
  end
  def down
    remove_column :bbcodes, :tag
    remove_column :bbcodes, :text
    remove_column :bbcodes, :singular
    remove_column :bbcodes, :match
  end
end
