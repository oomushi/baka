class Message < ApplicationRecord
  belongs_to :message
  belongs_to :user
  has_many :messages
  has_many :likes,dependent: :destroy
  has_many :attachments, dependent: :destroy
  has_one :poll,dependent: :destroy
  belongs_to :reader, class_name: "Group", foreign_key: "reader_id"
  belongs_to :writer, class_name: "Group", foreign_key: "writer_id"
  belongs_to :moderator, class_name: "Group", foreign_key: "moderator_id"
  before_create :set_nv_and_dv
  before_destroy :destroyable?
  #after_create :alert_followers
  validate :read_write?
  
=begin
  def default_scope
    group=User.current.groups.min_by(&:level)
    joins(:reader).where("groups.level>? or groups.id=?",group.level ,group.id)
  end
=end

  def like_it? user
    likes.any?{ |l| l.user==user }
  end
  def like_by user
    likes.detect{ |l| l.user_id=user.id } if like_it? user
  end
  
  def owner? user
    user.id==user_id
  end
  def childs user
    messages.joins(:reader).where('messages.id<>? and groups.level>=?',id,user.groups.min_by(&:level).level).order("created_at")
  end
  def ancestors user
    Message.joins(:reader).where("1.0*nv/dv<=1.0*?/? and 1.0*snv/sdv>1.0*?/? and section=false and groups.level>=?",nv,dv,nv,dv,user.groups.min_by(&:level).level).order("created_at")
  end
  def offsprings user
    Message.joins(:reader).where("1.0*nv/dv>=1.0*?/? and 1.0*nv/dv<1.0*?/? and section=false and groups.level>=?",nv,dv,snv,sdv,user.groups.min_by(&:level).level).order("created_at")
  end
  def paths user
    Message.joins(:reader).where("1.0*nv/dv<=1.0*?/? and 1.0*snv/sdv>1.0*?/? and section=true and groups.level>=?",nv,dv,nv,dv,user.groups.min_by(&:level).level).order("created_at")
  end
  
  def childs?
    !messages.count.zero?
  end
  
  def reply
    title,text='',''
    unless section
      title+=self.title
      title='[Re] '+title unless title=~/^\[Re\] /
      text="[quote=#{user.username}]#{self.text}[/quote]"
    end
    Message.new({
      title: title,
      text: text,
      message_id: self.id,
      reader_id: self.reader_id,
      writer_id: self.writer_id,
      moderator_id: self.moderator_id
    })
  end
  
  protected
  def destroyable?
      if childs?
        errors.add :base, I18n.t(:ko_message_undeletable)
        false
      end
    end
  def read_write?
    return if self.message.nil?
    errors.add :writer_id, I18n.t(:ko_message_writer) if self.writer.level>self.message.writer.level and !self.message.section
    errors.add :writer_id, I18n.t(:ko_message_readwrite) if self.writer.level>self.reader.level
    errors.add :reader_id, I18n.t(:ko_message_reader) if self.reader.level>self.message.reader.level
  end
  def set_nv_and_dv
    if dv.nil? or dv==0
      parent=Message.find message_id
      c=parent.messages.count+1
      c-=1 if parent.id==parent.message_id
      self.nv=parent.nv+c*parent.snv
      self.dv=parent.dv+c*parent.sdv
      self.snv=parent.nv+(c+1)*parent.snv
      self.sdv=parent.dv+(c+1)*parent.sdv
    end
  end
=begin
  def alert_followers
    return if self.id.eql? self.message_id
    msgs=MessageMailer.new_message_alert(self)
    begin
      msgs.deliver unless msgs.sender.nil?
     rescue
     end
  end
=end
end
