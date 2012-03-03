class AddFollowToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :follow, :boolean,:default=>true

  end
end
