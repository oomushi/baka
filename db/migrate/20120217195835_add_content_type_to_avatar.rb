class AddContentTypeToAvatar < ActiveRecord::Migration
  def change
    add_column :avatars, :content_type, :string

  end
end
