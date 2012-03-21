class Answer < ActiveRecord::Base
  belongs_to :poll
  has_and_belongs_to_many_with_deferred_save :users
  validate :unique_poll?

  def vote user
    self.users<<user
    save
  end
  protected
  def unique_poll?
    poll.answers.each do |a|
      next if a.eql? self
      unless (a.users & users).empty?
        errors.add :users, "this user already gives his option"
        return false
      end
    end
    true
  end
end
