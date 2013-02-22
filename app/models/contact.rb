class Contact < ActiveRecord::Base
  attr_accessible :value, :protocol, :user_id
  belongs_to :user
  validates_presence_of :protocol,:value
  validates_format_of :website, :with => URI::regexp(%w(http https)), :allow_black=>true, :allow_nil=>true
  
  ENUM=%w(website email)
end
