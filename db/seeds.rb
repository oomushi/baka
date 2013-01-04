# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Emanuel', :city => cities.first)
a=Group.create({
  :name=>"Admins",
  :level=>1
})
b=Group.create({
  :name=>"Moderators",
  :level=>2
})
b=Group.create({
  :name=>"Users",
  :level=>4
})
c=Group.create({
  :name=>"guest",
  :level=>64
})
admin = User.create(:username=>'Admin', :email=>'admin@baka.com', :birthday=>Date.new(1982,12,29), :password=>'sunset')
admin.confirm_code=nil
admin.groups<<a
admin.save
avatar=admin.avatar
avatar.url='/assets/admin.png'
avatar.save
guest=User.create(:username=>"guest",:email=>"guest@baka.com",:password=>"sunset",:guest=>true)
guest.groups<<c
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
root.moderator=a
root.save
# encoding: utf-8

Bbcode.create([
  { :tag => "spoiler", :label => "spoiler", :layout => "<span class=\"spoiler\">?</span>", :value => "", :inner => "?", :properties => 39, :created_at => "2012-09-16 11:29:00", :updated_at => "2012-09-16 11:29:00" },
  { :tag => "B", :label => "<img src=\"/assets/B.png\" alt=\":B\"/>", :layout => "<img src=\"/assets/B.png\" alt=\":B\"/>", :value => "", :inner => "", :properties => 52, :created_at => "2012-09-16 11:51:00", :updated_at => "2012-09-16 11:55:58" },
  { :tag => "P", :label => "<img src=\"/assets/P.png\" alt=\":P\"/>", :layout => "<img src=\"/assets/P.png\" alt=\":P\"/>", :value => "", :inner => "", :properties => 52, :created_at => "2012-09-17 16:34:24", :updated_at => "2012-09-17 16:34:53" },
  { :tag => "C", :label => "<img src=\"/assets/C.png\" alt=\":C\"/>", :layout => "<img src=\"/assets/C.png\" alt=\":C\"/>", :value => "", :inner => "", :properties => 52, :created_at => "2012-09-17 16:36:42", :updated_at => "2012-09-17 16:36:42" },
  { :tag => "D", :label => "<img src=\"/assets/D.png\" alt=\":D\"/>", :layout => "<img src=\"/assets/D.png\" alt=\":D\"/>", :value => "", :inner => "", :properties => 52, :created_at => "2012-09-17 16:37:09", :updated_at => "2012-09-17 16:37:09" },
  { :tag => "I", :label => "<img src=\"/assets/I.png\" alt=\":I\"/>", :layout => "<img src=\"/assets/I.png\" alt=\":I\"/>", :value => "", :inner => "", :properties => 52, :created_at => "2012-09-17 16:37:34", :updated_at => "2012-09-17 16:37:34" },
  { :tag => "O", :label => "<img src=\"/assets/O.png\" alt=\":O\"/>", :layout => "<img src=\"/assets/O.png\" alt=\":O\"/>", :value => "", :inner => "", :properties => 52, :created_at => "2012-09-17 16:37:59", :updated_at => "2012-09-17 16:37:59" },
  { :tag => "X", :label => "<img src=\"/assets/X.png\" alt=\":X\"/>", :layout => "<img src=\"/assets/X.png\" alt=\":X\"/>", :value => "", :inner => "", :properties => 52, :created_at => "2012-09-17 16:38:19", :updated_at => "2012-09-17 16:38:19" },
  { :tag => "quote", :label => "quote", :layout => "<fieldset class=\"quote\">?</fieldset>", :value => "<legend>?</legend>", :inner => "<blockquote>?</blockquote>", :properties => 39, :created_at => "2012-09-17 16:39:49", :updated_at => "2012-09-17 16:39:49" }
], :without_protection => true )


