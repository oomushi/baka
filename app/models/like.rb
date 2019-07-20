class Like < ApplicationRecord
  belongs_to :message
  belongs_to :user
  
  validate :unique?, on: :create
  validates :value, inclusion: { in: -1..1,  message: I18n.t(:ko_like_value) }
                  , numericality: { only_integer: true,  message: I18n.t(:ko_like_value) }
  protected
  def unique?
    errors.add(:user_id, I18n.t(:duplicate_like)) unless Like.where("user_id=? and message_id=?",self.user_id,self.message_id).count==0
  end
  private
  def owner? user
    self.user.id==user.id
  end
end
