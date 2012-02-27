class Poll < ActiveRecord::Base
  belongs_to :message
  has_many :poll_options
end
