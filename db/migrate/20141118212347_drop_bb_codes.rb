class DropBbCodes < ActiveRecord::Migration
  def up
    drop_table :bbcodes
  end

  def down
    create_table :bbcodes, :force => true do |t|
      t.string  :label
      t.string  :output
      t.string  :tag,        :default => "",   :null => false
      t.string  :text,       :default => "",   :null => false
      t.boolean :singular,   :default => true, :null => false
      t.string  :match,      :default => ".+", :null => false

      t.timestamps
    end
  end
end
