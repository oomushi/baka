class Poll < ActiveRecord::Base
  belongs_to :message
  has_many :answers,dependent: :destroy
  accepts_nested_attributes_for :answers, allow_destroy: true
  def options_count
    answers.inject(0){ |memo, o| memo+=o.users.count }
  end
  def voted? user
    answers.each do |po|
      if po.users.include? user
        return true
      end
    end
    false
  end
end
