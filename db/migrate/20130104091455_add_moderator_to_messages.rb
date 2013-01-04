class AddModeratorToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :moderator_id, :integer,:default=>2, :null=>false
    change_column :messages,:writer_id, :integer,:default=>1,:null=>false
    change_column :messages,:reader_id, :integer,:default=>1,:null=>false
  end
end
