# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Emanuel', :city => cities.first)
a=Group.create({
  :name=>"admins",
  :level=>1
})
b=Group.create({
  :name=>"moderators",
  :level=>2
})
b=Group.create({
  :name=>"logged users",
  :level=>4
})
c=Group.create({
  :name=>"public",
  :level=>64
})
admin = User.new(:username=>'admin', :birthday=>Date.new(1982,12,29), :provider=>"google_oauth2", :uid=>"108602441543843796359")
admin.contacts<<Contact.create(:value=>'admin@baka.com', :protocol=>'email')
admin.groups<<a
admin.save
avatar=admin.avatar
avatar.url='/assets/admin.png'
avatar.save
guest=User.new(:username=>"guest")
guest.contacts<<Contact.create(:value=>'guest@baka.com', :protocol=>'email')
guest.save
guest.groups=[c]
guest.save
root = Message.create({
  :text => "Hidden text",
  :title => "Baka",
  :section=>1,
  :pinned=>1,
  :message_id=>1,   
  :user_id=>admin.id,
  :nv=>0,
  :dv=>1,
  :snv=>1,
  :sdv=>1,
  :reader_id=>c.id,
  :writer_id=>a.id,
  :moderator_id=>a.id,
  :follow=>false
})
root.save
