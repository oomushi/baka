class Bbcode < ActiveRecord::Base
  def may_contain_text
    @properties&1
  end
  def may_contain_text= value
    @properties=val ? @properties|1 : @properties&~1
  end
  def may_not_be_empty
    @properties&2
  end
  def may_not_be_empty= value
    @properties=val ? @properties|2 : @properties&~2
  end
  def may_not_be_nested
    @properties&4
  end
  def may_not_be_nested= value
    @properties=val ? @properties|4 : @properties&~4
  end
  def may_not_contain_text
    @properties&8
  end
  def may_not_contain_text= value
    @properties=val ? @properties|8 : @properties&~8
  end
  def must_be_empty
    @properties&16
  end
  def must_be_empty= value
    @properties=val ? @properties|16 : @properties&~16
  end
  def may_be_nested
    @properties&32
  end
  def may_be_nested= value
    @properties=val ? @properties|32 : @properties&~32
  end
end
