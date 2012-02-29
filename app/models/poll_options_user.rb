class PollOptionsUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :poll_option
  validate :unique?,:on=>:create
  protected
  def unique?
    if user.poll_options.where('poll_id=?',poll_option.poll_id).count>0
      errors.add :base,"this user already gives his option"
      false
    end
  end
end
