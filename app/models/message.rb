class Message < ActiveRecord::Base
  include Canable::Ables
  belongs_to :user
  belongs_to :message
  has_many :messages
  has_many :likes,:dependent=>:destroy
  has_one :poll,:dependent=>:destroy
  belongs_to :reader, :class_name=>"Group", :foreign_key=>"reader_id"
  belongs_to :writer, :class_name=>"Group", :foreign_key=>"writer_id"
  accepts_nested_attributes_for :poll, :allow_destroy => true
  before_create :set_nv_and_dv
  before_destroy :destroyable?
  after_create :alert_followers

  def viewable_by? user
    reader.level>user.max_group.level or reader.eql? user.max_group
  end
  def creatable_by? user
    self.user.eql? user or ancestors(user).any?{ |m| m.writer.eql? user.max_group}
  end
  def updatable_by? user
    creatable_by? user
  end
  def destroyable_by? user
    creatable_by? user
  end
  
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
    user.id==self.user_id
  end
  def childs user
    messages.joins(:reader).where('messages.id<>? and groups.level>=?',self.id,user.max_group.level).order("created_at")
  end
  def ancestors user
    Message.joins(:reader).where("1.0*nv/dv<=1.0*?/? and 1.0*snv/sdv>1.0*?/? and section=false and groups.level>=?",self.nv,self.dv,self.nv,self.dv,user.max_group.level).order("created_at")
  end
  def offsprings user
    Message.joins(:reader).where("1.0*nv/dv between 1.0*?/? and 1.0*?/? and section=false and groups.level>=?",self.nv,self.dv,self.snv,self.sdv,user.max_group.level).order("created_at")
  end
  def paths user
    Message.joins(:reader).where("1.0*nv/dv<=1.0*?/? and 1.0*snv/sdv>1.0*?/? and section=true and groups.level>=?",self.nv,self.dv,self.nv,self.dv,user.max_group.level).order("created_at")
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
      :message_id=>self.id,
      :reader_id=>self.reader_id,
      :writer_id=>self.writer_id
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
    msgs=MessageMailer.new_message_alert(self)
    msgs.deliver unless msgs.sender.nil?
  end
end

