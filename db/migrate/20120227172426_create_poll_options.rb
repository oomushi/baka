class CreatePollOptions < ActiveRecord::Migration
  def change
    create_table :poll_options do |t|
      t.string :text,:null=>false
      t.integer :poll_id,:null=>false

      t.timestamps
    end
  end
end
