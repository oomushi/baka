class Message < ActiveRecord::Base
  belongs_to :user
  belongs_to :message
  has_many :messages
  has_many :likes
  before_create :set_lft_and_rgt
  after_create :update_lft_and_rgt
  before_destroy :destroyable?
  before_destroy :reset_lft_and_rgt

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
  
  def owner? user
    user.id=self.user_id
  end
  def ancestors
    Message.where("lft<=? and rgt>=? and section=false",self.lft,self.rgt).order("created_at")
  end
  def offsprings
    Message.where("lft>? and rgt<? and section=false",self.lft,self.rgt).order("created_at")
  end
  def paths
    Message.where("lft<=? and rgt>=? and section=true",self.lft,self.rgt).order("created_at")
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
  def set_lft_and_rgt
    if self.lft.nil? or self.rgt.nil?
      parent=Message.find self.message_id
      self.lft=parent.rgt
      self.rgt=parent.rgt+1
    end
  end
  def update_lft_and_rgt
    m1=Message.where("lft>? and id<>?",self.lft,self.id)
    m2=Message.where("rgt>=? and id<>?",self.lft,self.id)
    m1.each do |m|
      m.lft+=2
      m.save
    end
    m2.each do |m|
      m.rgt+=2
      m.save
    end
  end
  def reset_lft_and_rgt 
    m1=Message.where("message_id=?",self.id)
    m2=Message.where("lft>? and rgt>?",self.lft,self.rgt)
    m3=Message.where("lft>? and rgt<?",self.lft,self.rgt)
    m4=Message.where("lft<? and rgt>?",self.lft,self.rgt)
    m1.each do |m|
      m.message_id=self.message_id
      m.save
    end
   m2.each do |m|
      m.rgt-=2
      m.lft-=2
      m.save
    end
    m3.each do |m|
      m.rgt-=1
      m.lft-=1
      m.save
    end
    m4.each do |m|
      m.rgt-=2
      m.save
    end
  end
end

