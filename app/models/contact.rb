class Contact < ActiveRecord::Base
  attr_accessible :value, :protocol, :user_id
  belongs_to :user
  validates_presence_of :protocol,:value
  validates_format_of :value, :with => URI::regexp(%w(http https)), :allow_black=>false, :allow_nil=>false, :if => Proc.new{|c| c.protocol.eql? 'website'}
  validates_format_of :value, :with => /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/, :allow_black=>false, :allow_nil=>false, :if => Proc.new{|c| c.protocol.eql? 'email'} 
  
  ENUM=%w(website email)
end
