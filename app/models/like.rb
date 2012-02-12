class Like < ActiveRecord::Base
  belongs_to :user
  belongs_to :message
  validates_numericality_of :value, :only_integer => true, :message => "like value can only be whole number."
  validates_inclusion_of :value, :in => -1..1, :message => "can only be between -1 and 1." 
  validate :unique?, :on=>:create

  protected
  def unique?
    errors.add(:user_id, "like already posted") unless Like.where("user_id=? and message_id=?",self.user_id,self.message_id).count==0
  end
end
