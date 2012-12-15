class Group < ActiveRecord::Base
  has_and_belongs_to_many :users,:conditions => "confirm_code is null"
  before_destroy :destroyable?

  def ancestors
    Group.where("1.0*nv/dv<=1.0*?/? and 1.0*snv/sdv>1.0*?/?",self.nv,self.dv,self.nv,self.dv).order("created_at")
  end
  def deletable?
    users.count.zero?
  end
  def admin?
    level==1
  end
  
  protected
  def destroyable?
    unless deletable?
      errors.add :base,"cannot delete group with users"
      false
    end
  end
end
