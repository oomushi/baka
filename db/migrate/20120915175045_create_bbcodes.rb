class CreateBbcodes < ActiveRecord::Migration
  def change
    create_table :bbcodes do |t|
      t.string :tag
      t.string :label
      t.string :layout
      t.string :value
      t.string :inner
      t.integer :attributes

      t.timestamps
    end
    add_index :bbcodes,:tag,:unique=>true
  end
end
