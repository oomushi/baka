class RenameContactsColumnClass < ActiveRecord::Migration
  def change
    rename_column :contacts, :class, :protocol
  end
end
