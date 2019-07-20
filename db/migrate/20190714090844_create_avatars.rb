class CreateAvatars < ActiveRecord::Migration[5.2]
  def change
    create_table :avatars do |t|
      t.references :user, foreign_key: true, null: false
      t.string :url
      t.binary :file, null: false

      t.timestamps
    end
  end
end
