class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name
      t.integer :group_id
      t.integer :nv,:default=>0,:limit=>8
      t.integer :dv,:default=>0,:limit=>8
      t.integer :snv,:default=>0,:limit=>8
      t.integer :sdv,:default=>0,:limit=>8

      t.timestamps
    end
  end
end
