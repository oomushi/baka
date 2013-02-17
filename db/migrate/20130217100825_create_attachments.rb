class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.string :name
      t.string :content_type
      t.binary :file
      t.integer :message_id

      t.timestamps
    end
  end
end
