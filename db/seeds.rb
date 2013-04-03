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
admin = User.create(:username=>'admin', :birthday=>Date.new(1982,12,29), :password=>'sunset', :confirm_code=>nil)
Contact.create(:value=>'admin@baka.com', :protocol=>'email',:user_id=>admin.id)
admin.groups<<a
admin.save
avatar=admin.avatar
avatar.url='/assets/admin.png'
avatar.save
guest=User.new(:username=>"guest",:password=>"sunset",:guest=>true)
Contact.create(:value=>'guest@baka.com', :protocol=>'email',:user_id=>guest.id)
guest.groups<<c
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

# encoding: utf-8
Bbcode.create([
  { :label => "spoiler", :created_at => "2012-09-16 11:29:00", :updated_at => "2013-03-02 11:58:15", :output => "[spoiler]?[/spoiler]", :tag => "spoiler", :text => "<span class=\"spoiler\">\#{content}</span>", :singular => false, :match => ".+" },
  { :label => "B)", :created_at => "2012-09-16 11:51:00", :updated_at => "2013-03-02 11:58:15", :output => "B)", :tag => "", :text => "", :singular => true, :match => ".+" },
  { :label => ":(", :created_at => "2012-09-17 16:36:42", :updated_at => "2013-03-02 11:58:15", :output => ":(", :tag => "", :text => "", :singular => true, :match => ".+" },
  { :label => ":/", :created_at => "2012-09-17 16:37:34", :updated_at => "2013-03-02 11:58:15", :output => ":/", :tag => "", :text => "", :singular => true, :match => ".+" },
  { :label => ":)", :created_at => "2013-03-02 16:13:56", :updated_at => "2013-03-02 16:13:56", :output => ":)", :tag => "", :text => "", :singular => true, :match => ".+" },
  { :label => ":^)", :created_at => "2013-03-02 16:15:14", :updated_at => "2013-03-02 16:15:14", :output => ":^)", :tag => "", :text => "", :singular => true, :match => ".+" },
  { :label => ";)", :created_at => "2013-03-02 16:15:45", :updated_at => "2013-03-02 16:15:45", :output => ";)", :tag => "", :text => "", :singular => false, :match => ".+" },
  { :label => ":'(", :created_at => "2013-03-02 16:16:54", :updated_at => "2013-03-02 16:16:54", :output => ":'(", :tag => "", :text => "", :singular => true, :match => ".+" },
  { :label => "O_o", :created_at => "2013-03-02 16:18:32", :updated_at => "2013-03-02 16:18:32", :output => "O_o", :tag => "", :text => "", :singular => true, :match => ".+" },
  { :label => "T_T", :created_at => "2013-03-02 16:19:00", :updated_at => "2013-03-02 16:19:00", :output => "T_T", :tag => "", :text => "", :singular => true, :match => ".+" },
  { :label => "<3", :created_at => "2013-03-03 13:55:31", :updated_at => "2013-03-03 13:55:31", :output => "<3", :tag => "", :text => "", :singular => true, :match => ".+" },
  { :label => ":X", :created_at => "2012-09-17 16:38:19", :updated_at => "2013-03-02 11:58:15", :output => ":X", :tag => "", :text => "", :singular => true, :match => ".+" },
  { :label => ":O", :created_at => "2012-09-17 16:37:59", :updated_at => "2013-03-02 11:58:15", :output => ":O", :tag => "", :text => "", :singular => true, :match => ".+" },
  { :label => ":D", :created_at => "2012-09-17 16:37:09", :updated_at => "2013-03-02 11:58:15", :output => ":D", :tag => "", :text => "", :singular => true, :match => ".+" },
  { :label => ":P", :created_at => "2012-09-17 16:34:24", :updated_at => "2013-03-02 11:58:15", :output => ":P", :tag => "", :text => "", :singular => true, :match => ".+" },
  { :label => "quote", :created_at => "2012-09-17 16:39:49", :updated_at => "2013-03-02 11:58:15", :output => "[quote='?']?[/quote]", :tag => "quote", :text => "<fieldset class=\"quote\"><legend>\#{meta}</legend><blockquote>\#{content}</blockquote></fieldset>", :singular => false, :match => ".+" }
], :without_protection => true )


