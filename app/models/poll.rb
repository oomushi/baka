class Poll < ApplicationRecord
  belongs_to :message
  has_many :choises, dependent: :destroy
  has_many :answers, through: :choises
  
  def options_count
    choises.inject(0){ |memo, o| memo+=o.users.count }
  end
  def voted? user
    answers.any?{ |a| a.user=user }
  end
end
