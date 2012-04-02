# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Emanuel', :city => cities.first)
a=Group.create({
  :name=>"Admins",
  :nv=>0,
  :dv=>1,
  :snv=>1,
  :sdv=>1
})
Group.create({
  :name=>"Moderetors",
  :nv=>1,
  :dv=>2,
  :snv=>2,
  :sdv=>3,
  :group_id=>a.id
})
b=Group.create({
  :name=>"Users",
  :nv=>1,
  :dv=>1,
  :snv=>2,
  :sdv=>1
})
admin = User.create(:username=>'Admin', :email=>'admin@baka.com', :birthday=>Date.new(1982,12,29), :password=>'sunset')
admin.confirm_code=nil
admin.groups<<a
admin.save
avatar=admin.avatar
avatar.url='/assets/users/admin.png'
avatar.save
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
  :sdv=>1
})
root.reader=b
root.writer=a
root.save
