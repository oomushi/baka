class PollOption < ActiveRecord::Base
  belongs_to :poll
  has_many :poll_options_users,:dependent=>:destroy
  has_many :users,:through => :poll_options_users,:dependent=>:destroy
end
