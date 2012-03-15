class Message < ActiveRecord::Base
  belongs_to :user
  belongs_to :message
  has_many :messages
  has_many :likes,:dependent=>:destroy
  has_one :poll,:dependent=>:destroy
  accepts_nested_attributes_for :poll, :allow_destroy => true
  before_create :set_nv_and_dv
  before_destroy :destroyable?
  after_create :alert_followers

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
    Message.where("1.0*nv/dv<=1.0*?/? and 1.0*snv/sdv>1.0*?/? and section=false",self.nv,self.dv,self.nv,self.dv).order("created_at")
  end
  def offsprings
    Message.where("1.0*nv/dv between 1.0*?/? and 1.0*?/? and section=false",self.nv,self.dv,self.snv,self.sdv).order("created_at")
  end
  def paths
    Message.where("1.0*nv/dv<=1.0*?/? and 1.0*snv/sdv>1.0*?/? and section=true",self.nv,self.dv,self.nv,self.dv).order("created_at")
  end
  
  def deletable?
    messages.count.zero?
  end
  
  def replay
    title,text='',''
    unless self.section
      title+=self.title
      title='[Re] '+title unless title=~/^\[Re\] /
      text="[quote=#{self.user.username}]#{self.text}[/quote]"
    end
    Message.new({
      :title=>title,
      :text=>text,
      :message_id=>self.id
    })
  end

  protected
  def destroyable?
    unless deletable?
      errors.add :base,"cannot delete message with replayes"
      false
    end
  end
  def set_nv_and_dv
    if self.dv.nil? or self.dv==0
      parent=Message.find self.message_id
      c=parent.messages.count+1
      c-=1 if parent.id==parent.message_id
      self.nv=parent.nv+c*parent.snv
      self.dv=parent.dv+c*parent.sdv
      self.snv=parent.nv+(c+1)*parent.snv
      self.sdv=parent.dv+(c+1)*parent.sdv
    end
  end
  def alert_followers
    MessageMailer.new_message_alert(self).deliver
  end
end

