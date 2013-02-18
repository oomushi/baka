class Contact < ActiveRecord::Base
  attr_accessible :value, :protocol, :user_id
  belongs_to :user
  validates_presence_of :protocol,:value
end
