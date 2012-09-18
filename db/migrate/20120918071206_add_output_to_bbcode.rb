class AddOutputToBbcode < ActiveRecord::Migration
  def change
    add_column :bbcodes, :output, :string

  end
end
