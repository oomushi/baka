class Message < ActiveRecord::Base
  belongs_to :user
  belongs_to :message
  has_may :messages

  def ancestors
    Message.where("lft<=? and rgt>=?",@lft,@rgt).order("created_at")
  end
  def save
    unless @id
      newrecord=true
      parent=Message.find @message_id
      @lft=parent.rgt
      @rgt=parent.rgt+1
    end
    super
    if newrecord
      m1=Message.where("lft>? and id<>?",@lft,@id)
      m2=Message.where("rgt>=? and id<>?",@lft,@id)
      m1.each do |m|
        m.lft+=2
        m.save
      end
      m2.each do |m|
        m.rgt+=2
        m.save
      end
    end
  end
  def delete id
    msg=Message.find id
    m1=Message.where("message_id=?",id)
    m2=Message.where("lft>? and rgt>?",msg.lft,msg.rgt)
    m3=Message.where("lft>? and rgt<?",msg.lft,msg.rgt)
    m4=Message.where("lft<? and rgt>?",msg.lft.msg.rgt)
    m1.each do |m|
      m.message_id=msg.message_id
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
    super id
  end
end
