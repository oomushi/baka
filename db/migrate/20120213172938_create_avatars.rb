class CreateAvatars < ActiveRecord::Migration
  def up
    create_table :avatars do |t|
      t.integer :user_id, :null=>false
      t.string :url, :default=>"/assets/guest.png"
      t.binary :file

      t.timestamps
    end
    User.all.each do |u|
      Avatar.create({:user_id=>u.id,:url=>u.avatar})
    end
  end

  def down
    Avatar.all.each do |a|
      u=a.user
      u.avatar=a.url
      u.save
    end
    drop_table :avatars
  end
end
