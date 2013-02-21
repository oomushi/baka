class RenameContactsColumnClass < ActiveRecord::Migration
  def up
    rename_column :contacts, :class, :protocol
    User.all.each do |u|
      Contact.create({user_id: u.id, protocol: 'email', value: u.email }) unless u.email.nil?
      Contact.create({user_id: u.id, protocol: 'website', value: u.website }) unless u.website.nil?
    end
  end
  def down
    Contact.all.each do |c|
      case c.protocol
        when 'email'
          c.user.email=c.value
          c.user.save
        when 'website'
          c.user.website=c.value
          c.user.save
      end
    end
    rename_column :contacts, :protocol, :class
  end
end
