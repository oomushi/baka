# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Emanuel', :city => cities.first)
admin = User.new
admin.username='Admin' 
admin.email='admin@baka.com'
admin.birthday=Date.new(1982,12,29)
admin.avatar='/assets/users/admin.png'
admin.password='sunset'
admin.password_confirmation='sunset'
admin.save
root = Message.create({
  :text => "Questo non lo leggera' nessuno",
  :title => "ROOT title",
  :section=>1,
  :pinned=>1,
  :message_id=>1,   
  :user_id=>admin.id,
  :lft=>1,
  :rgt=>2
})
