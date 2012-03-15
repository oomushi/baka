class Poll < ActiveRecord::Base
  belongs_to :message
  has_many :poll_options,:dependent=>:destroy
  accepts_nested_attributes_for :poll_options, :allow_destroy => true
  def initialize a,b
    super a,b
    poll_options.build if poll_options.count.zero?
  end
  def options_count
    poll_options.inject{ |memo, o| memo+=o.users.count }
  end
  def voted user
    poll_options.each do |po|
      if po.users.include? user
        return true
      end
    end
    false
  end
end
