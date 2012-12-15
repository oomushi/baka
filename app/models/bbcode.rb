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
  
  def text _value,_inner
    tmp=''
    tmp+=self.value.gsub '?',_value unless self.value.eql? '' || self.value.nil?
    tmp+=self.inner.gsub '?',_inner unless self.inner.eql? '' || self.inner.nil?
    self.layout.gsub '?',tmp
  end

  def tag
    $1 if self.output =~ /^\[:?(\w+)(=.+?)?\]/
  end  

  def may_contain_text
    self.properties&1
  end
  def may_contain_text= value
    self.properties=val ? self.properties|1 : self.properties&~1
  end
  def may_not_be_empty
    self.properties&2
  end
  def may_not_be_empty= value
    self.properties=val ? self.properties|2 : self.properties&~2
  end
  def may_not_be_nested
    self.properties&4
  end
  def may_not_be_nested= value
    self.properties=val ? self.properties|4 : self.properties&~4
  end
  def may_not_contain_text
    self.properties&8
  end
  def may_not_contain_text= value
    self.properties=val ? self.properties|8 : self.properties&~8
  end
  def must_be_empty
    self.properties&16
  end
  def must_be_empty= value
    self.properties=val ? self.properties|16 : self.properties&~16
  end
  def may_be_nested
    self.properties&32
  end
  def may_be_nested= value
    self.properties=val ? self.properties|32 : self.properties&~32
  end
end
