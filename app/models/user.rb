class User < ActiveRecord::Base
  include Canable::Cans
  include Canable::Ables
  has_many :messages,:dependent=>:destroy
  has_many :likes,:dependent=>:destroy
  has_one :avatar,:dependent=>:delete
  has_many :contacts,:dependent=>:destroy
  has_and_belongs_to_many :answers
  has_and_belongs_to_many :groups
  attr_protected :password_hash, :password_salt, :confirm_code
  attr_accessor :password
  before_save :encrypt_password
  after_create :confirm_email,:create_avatar,:add_group
  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :username,:email
  validates_uniqueness_of :username
  validates_format_of :website, :with => URI::regexp(%w(http https)), :allow_black=>true, :allow_nil=>true
  
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
  
  def self.authenticate(username, password)
    user = User.where("username = ? and confirm_code is null",username).first
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end
  
  def confirm code
    if code.eql? self.confirm_code
      self.confirm_code=nil
      self.save
      true
    else
      false
    end
  end
  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end
  protected
  def confirm_email
    salt=BCrypt::Engine.generate_salt
    self.confirm_code=BCrypt::Engine.hash_secret("#{self.id} #{self.username} #{self.email} #{self.password_hash} #{self.password_salt} #{self.created_at.to_s} #{rand(29**29)}", salt)
    self.save
    begin
      UserMailer.email_confirmation(self).deliver
    rescue
      self.destroy
    end
  end
  def create_avatar
    Avatar.create({:user_id=>self.id})
  end
  def add_group
    self.groups<<Group.find(3)
  end
end
