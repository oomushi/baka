class AnswersUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :answer
  validate :unique?,:on=>:create
  protected
  def unique?
    if user.answers.where('poll_id=?',answer.poll_id).count>0
      errors.add :base,"this user already gives his option"
      false
    end
  end
end
