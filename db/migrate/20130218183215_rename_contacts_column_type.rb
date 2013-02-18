class RenameContactsColumnType < ActiveRecord::Migration
  def change
    rename_column :contacts, :type, :class
  end
end
