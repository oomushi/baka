class Message < ActiveRecord::Base
  belongs_to :user
  belongs_to :message
  has_many :messages
  before_create :set_lft_and_rgt
  after_create :update_lft_and_rgt
  before_destroy :reset_lft_and_rgt

  def ancestors
    Message.where("lft<=? and rgt>=?",self.lft,self.rgt).order("created_at")
  end
  def offsprings
    Message.where("lft>? and rgt<?",self.lft,self.rgt).order("created_at")
  end

  protected
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

