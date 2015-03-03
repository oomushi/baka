class Like < ActiveRecord::Base
  include Canable::Ables
  belongs_to :user
  belongs_to :message
  validates_numericality_of :value, only_integer: true, message: I18n.t(:ko_like_type)
  validates_inclusion_of :value, in: -1..1, message: I18n.t(:ko_like_value) 
  validate :unique?, on: :create

  def creatable_by? user
    !user.guest?
  end
  def updatable_by? user
    owner? user
  end
  def destroyable_by? user
    owner? user
  end

  protected
  def unique?
    errors.add(:user_id, I18n.t(:duplicate_like)) unless Like.where("user_id=? and message_id=?",self.user_id,self.message_id).count==0
  end
  private
  def owner? user
    self.user.id==user.id
  end
end
