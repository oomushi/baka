class Group < ActiveRecord::Base
  include Canable::Ables
  include Comparable
  has_and_belongs_to_many :users,:conditions => "confirm_code is null"
  before_destroy :destroyable?

  def self.indexable_by? user
    user.admin?
  end
  def viewable_by? user
    Group.indexable_by? user
  end
  def creatable_by? user
    Group.indexable_by? user
  end
  def updatable_by? user
    Group.indexable_by? user
  end
  def destroyable_by? user
    Group.indexable_by? user
  end

  def ancestors
    Group.where("level<? and level<64",level).order("created_at")
  end
  def offsprings
    Group.where("level>=? and level<64",level).order("created_at")
  end
  
  def childs?
    users.count.zero?
  end
  def admin?
    level==1
  end
  
  def <=> obj
    -(self.level<=>obj.level)
  end
  
  protected
  def destroyable?
    if childs?
      errors.add :base,t(:ko_group_not_empty)
      false
    end
  end
end
