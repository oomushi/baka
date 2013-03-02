class Bbcode < ActiveRecord::Base
  include Canable::Ables
  
  def self.indexable_by? user
    user.admin?
  end
  def viewable_by? user
    Bbcode.indexable_by? user
  end
  def creatable_by? user
    Bbcode.indexable_by? user
  end
  def updatable_by? user
    Bbcode.indexable_by? user
  end
  def destroyable_by? user
    Bbcode.indexable_by? user
  end
  
  def example meta, content
    output.sub('?',meta).sub('?',content)
  end
end
