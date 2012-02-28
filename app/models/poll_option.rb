class PollOption < ActiveRecord::Base
  belongs_to :poll
  has_and_belongs_to_many :users,:uniq => true,:before_add => :unique?
  protected
  def unique? user
    if user.poll_options.where('poll_id=?',self.poll_id).count>0
      errors.add :base,"this user already gives his option"
      false
    end
  end
end
