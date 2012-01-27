# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Emanuel', :city => cities.first)
admin = User.create({
  :username=>'Admin',
  :email=>'admin@baka.com',
  :birthday=>Date.new(1982,12,29),
})
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
