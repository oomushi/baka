class Poll < ActiveRecord::Base
  belongs_to :message
  has_many :poll_options,:dependent=>:destroy
  accepts_nested_attributes_for :poll_options, :allow_destroy => true
  def options_count
    poll_options.inject(0){ |memo, o| memo+=o.users.count }
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
