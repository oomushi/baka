class Poll < ActiveRecord::Base
  belongs_to :message
  has_many :poll_options
  def options_count
    poll_options.inject{ |memo, o| memo+=o.users.count }
  end
end
