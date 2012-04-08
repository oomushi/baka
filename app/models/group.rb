class Group < ActiveRecord::Base
  belongs_to :group
  has_many :groups
  has_and_belongs_to_many :users,:conditions => "confirm_code is null"
  before_create :set_nv_and_dv
  before_destroy :destroyable?
  before_update :update_others_nv
  after_update :update_my_nv

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
  def update_others_nv
    return '' if group.nil?
    c=group.groups.count-1
    if c>0
      group.groups.each do |g|
        next if g.id==self.id
        g.nv=group.nv+c*group.snv
        g.dv=group.dv+c*group.sdv
        g.snv=group.nv+(c+1)*group.snv
        g.sdv=group.dv+(c+1)*group.sdv
        g.save
      end
    end
  end
  def update_my_nv
    return '' if group.nil?
    unless 1.0*group.nv/group.dv<1.0*nv/dv and 1.0*group.snv/group.sdv>1.0*nv/dv
      c=group.groups.count
      self.nv=group.nv+c*group.snv
      self.dv=group.dv+c*group.sdv
      self.snv=group.nv+(c+1)*group.snv
      self.sdv=group.dv+(c+1)*group.sdv
      save
    end
  end
end
