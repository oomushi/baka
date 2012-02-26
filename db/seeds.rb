# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Emanuel', :city => cities.first)
admin = User.create(:username=>'Admin', :email=>'admin@baka.com', :birthday=>Date.new(1982,12,29), :password=>'sunset')
admin.avatar=Avatar.create({:url=>'/assets/users/admin.png'})
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
