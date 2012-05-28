class DeleteNvFromGroups < ActiveRecord::Migration
  def change
    add_column :groups, :level, :integer, :default=>1
    remove_column :groups, :nv
    remove_column :groups, :dv
    remove_column :groups, :snv
    remove_column :groups, :sdv
    remove_column :groups, :group_id
  end
end
