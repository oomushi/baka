class CreateContacts < ActiveRecord::Migration
  def up
    create_table :contacts do |t|
      t.integer :user_id
      t.string :type
      t.string :value

      t.timestamps
    end
    User.all.each do |u|
      Contact.create({user_id: u.id, type: 'email', value: u.email }) unless u.email.nil?
      Contact.create({user_id: u.id, type: 'website', value: u.website }) unless u.website.nil?
    end
  end
  
  def down
    Contact.all.each do |c|
      case c.type
        when 'email'
          c.user.email=c.value
          c.user.save
        when 'website'
          c.user.website=c.value
          c.user.save
      end
    end
    drop_table :contacts
  end
end
