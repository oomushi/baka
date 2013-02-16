class Contact < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :type,:value
end
