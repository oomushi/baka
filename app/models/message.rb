class Message < ActiveRecord::Base
  belongs_to :user
  belongs_to :message
  has_many :messages
  has_many :likes
  before_create :set_nv_and_dv
  before_destroy :destroyable?

  def total_likes
    value=0
    likes.each do |l|
      value+=l.value
    end
    value
  end
  def like_it? user
    likes.any?{ |l| l.user==user }
  end
  def like_by user
    likes.detect{ |l| l.user_id=user.id } if like_it? user
  end
  
  def owner? user
    user.id=self.user_id
  end
  def ancestors
    Message.where("1.0*nv/dv<=? and 1.0*snv/sdv>=? and section=false",1.0*self.nv/self.dv,1.0*self.nv/self.dv).order("created_at")
  end
  def offsprings
    Message.where("1.0*nv/dv between ? and ? and section=false",1.0*self.nv/self.dv,1.0*self.snv/self.sdv).order("created_at")
  end
  def paths
    Message.where("1.0*nv/dv<=? and 1.0*snv/sdv>=? and section=true",1.0*self.nv/self.dv,1.0*self.nv/self.dv).order("created_at")
  end
  
  def deletable?
    messages.count.zero?
  end

  protected
  def destroyable?
    unless deletable?
      errors.add :base,"cannot delete message with replayes"
      false
    end
  end
  def set_nv_and_dv
    if self.nv.nil? or self.dv.nil? or self.snv.nil? or self.sdv.nil?
      parent=Message.find self.message_id
      c=parent.messages.count
      self.nv=parent.nv+c*parent.snv
      self.dv=parent.dv+c*parent.sdv
      self.snv=parent.nv+(c+1)*parent.snv
      self.sdv=parent.dv+(c+1)*parent.sdv
    end
  end
end

