class Group < ApplicationRecord
  has_many :memberships
  has_many :users, through: :memberships
  before_destroy :destroyable?
  
  def ancestors
    Group.where("level<? and level<64",level).order("created_at")
  end
  def offsprings
    Group.where("level>=? and level<64",level).order("created_at")
  end
  
  def childs?
    ! users.count.zero?
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
      errors.add :base,I18n.t(:ko_group_not_empty)
      false
    end
  end
end
