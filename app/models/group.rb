class Group < ActiveRecord::Base
  belongs_to :group
  has_many :groups
  has_and_belongs_to_many :users,:conditions => "confirm_code is null"
  before_create :set_nv_and_dv
  before_destroy :destroyable?
  
  def ancestors
    Group.where("1.0*nv/dv<=1.0*?/? and 1.0*snv/sdv>1.0*?/?",self.nv,self.dv,self.nv,self.dv).order("created_at")
  end
  def deletable?
    users.count.zero?
  end
  protected
  def destroyable?
    unless deletable?
      errors.add :base,"cannot delete group with users"
      false
    end
  end
  def set_nv_and_dv
    if self.dv.nil? or self.dv==0
      parent=Group.find self.group_id
      c=parent.groups.count+1
      c-=1 if parent.id==parent.group_id
      self.nv=parent.nv+c*parent.snv
      self.dv=parent.dv+c*parent.sdv
      self.snv=parent.nv+(c+1)*parent.snv
      self.sdv=parent.dv+(c+1)*parent.sdv
    end
  end
end
