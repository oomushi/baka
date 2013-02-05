class Answer < ActiveRecord::Base
  include Canable::Ables
  belongs_to :poll
  has_and_belongs_to_many_with_deferred_save :users
  validate :unique_poll?

  def votable_by? user
    !user.guest? # guest cann't vote
  end
  def destroyable_by? user
    self.poll.message.updatable_by? user # only owner can delete vote
  end
  def vote user
    self.users<<user
    save
  end
  protected
  def unique_poll?
    poll.answers.each do |a|
      next if a.eql? self
      unless (a.users & users).empty?
        errors.add :users, t(:duplicate_answer) 
        return false
      end
    end unless poll.nil?
    true
  end
end
