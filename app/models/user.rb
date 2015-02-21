class User < ActiveRecord::Base
  include Canable::Cans
  include Canable::Ables
  has_many :messages,:dependent=>:destroy
  has_many :likes,:dependent=>:destroy
  has_one :avatar,:dependent=>:delete
  has_many :contacts,:dependent=>:destroy
  has_and_belongs_to_many :answers
  has_and_belongs_to_many :groups
  after_create {|u| u.create_avatar}
  after_create {|u| u.groups<<Group.find(3)}
  #before_create :import_contact 
  validates_presence_of :username
  validates_uniqueness_of :username
  accepts_nested_attributes_for :contacts, :allow_destroy => true
  accepts_nested_attributes_for :avatar, :allow_destroy => false
  
  def updatable_by? user
    user.id==id or
      user.admin?
  end
  def destroyable_by? user
    updatable_by?(user) and
      messages.count.zero? and
      likes.count.zero? and
      answers.count.zero?
  end
  
  def self.current
    @@current
  end
  def self.current= user
    @@current=user
  end
  
  def value
    username
  end 

  def posts
    messages.where("section = ?", false)
  end
  
  def self.guest
    where("uid is ?",nil)
  end
  def guest?
    uid.nil?
  end
  def admin?
    groups.any?{ |g| g.admin? }
  end

  def self.authenticate auth
    where(auth.slice(:provider, :uid)).first
  end
  def email
    email=contacts.where('protocol = ?','email').first
    email.nil? ? '' : email.value
  end

=begin 
  protected
  def import_contact auth   
    _or_initialize.tap do |user|
      logger.debug auth.info
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end
  end
  def email= value
    email=contacts.where('protocol = ?','email').first
    if email.nil?
      contacts<<Contact.create(:value=>value, :protocol=>'email')
    else 
      email.value=value
      email.save!
    end
  end
=end
end
