class CreateAttachments < ActiveRecord::Migration[5.2]
  def change
    create_table :attachments do |t|
      t.string :name
      t.string :content_type
      t.binary :file
      t.references :message, foreign_key: true

      t.timestamps
    end
  end
end
