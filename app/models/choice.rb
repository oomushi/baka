class Choice < ApplicationRecord
  belongs_to :poll
  has_many :answers
  has_many :uses, through: :answers
  validate :unique_poll?
  
  def votable_by? user
    !user.guest? # guest cann't vote
  end
  
  protected
  def unique_poll?
    poll.choises.each do |a|
      next if a.eql? self
      unless (a.users & users).empty?
        errors.add :users, I18n.t(:duplicate_answer) 
        return false
      end
    end unless poll.nil?
    true
  end
end
