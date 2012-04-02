class Group < ActiveRecord::Base
  belongs_to :group
  has_many :groups
  has_and_belongs_to_many :user
  before_create :set_nv_and_dv
  
  def ancestors
    Group.where("1.0*nv/dv<=1.0*?/? and 1.0*snv/sdv>1.0*?/?",self.nv,self.dv,self.nv,self.dv).order("created_at")
  end
  protected
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
