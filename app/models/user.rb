class User < ActiveRecord::Base
  include Canable::Cans
  include Canable::Ables
  has_many :messages,:dependent=>:destroy
  has_many :likes,:dependent=>:destroy
  has_one :avatar,:dependent=>:delete
  has_many :contacts,:dependent=>:destroy
  has_and_belongs_to_many :answers
  has_and_belongs_to_many :groups
  after_create :confirm_email,:generate_avatar,:add_group
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
  def total_likes
    value=0
    self.likes.each do |l|
      value+=l.value
    end
    value
  end
  def posts
    messages.where("section = ?", false)
  end
  
  def self.find_guest
    User.where("guest = ?",true)
  end
  def guest?
    guest==true
  end
  def admin?
    groups.any?{ |g| g.admin? }
  end
  
  def max_group
    g=groups.sort{|a,b| a.level<=>b.level}
    g.first
  end
  
  def self.authenticate(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end
  end
  def email
    email=contacts.where('protocol = ?','email').first
    email.nil? ? '' : email.value
  end
  
  protected
  def confirm_email
    return if self.confirm_code.nil? or not self.email.eql? ''
    salt=BCrypt::Engine.generate_salt
    self.confirm_code=BCrypt::Engine.hash_secret("#{self.id} #{self.username} #{self.email} #{self.password_hash} #{self.password_salt} #{self.created_at.to_s} #{rand(29**29)}", salt)
    self.save
    begin
      UserMailer.email_confirmation(self).deliver
    rescue
      self.destroy
    end
  end
  def generate_avatar
    self.create_avatar()
  end
  def add_group
    self.groups<<Group.find(3)
  end
end
