class MergeAvatarFields < ActiveRecord::Migration[5.2]
  def up
    change_column :avatars, :url, :text, null: false, :default => "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAABmJLR0QA/wD/AP+gvaeTAAAACXBIWXMAAAsTAAALEwEAmpwYAAAAB3RJTUUH4wcUBzIzZrD8tgAAAAxpVFh0Q29tbWVudAAAAAAAvK6ymQAAAAtJREFUCNdjYAACAAAFAAHiJgWbAAAAAElFTkSuQmCC"
    remove_column :avatars, :file
  end
  def down
    add_column :avatars, :file, :binary, :default => "\\xc289504e470d0a1a0a", null: false
    change_column :avatars, :url, :string, null: true, :default => nil
  end
end
