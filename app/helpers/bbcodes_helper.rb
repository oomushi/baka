module BbcodesHelper
  def bb text
    if ! text.nil? and text!=''
      hm=CCParser.instance
      sc=hm.schema
      bb = RbbCode::Parser.new(:html_maker=>hm,:schema=>sc)
      bb.parse(text).html_safe
    end
  end
  private
  class CCParser < RbbCode::HtmlMaker # Singleton
    include Singleton
    def schema
      @schema
    end
    def initialize
      @schema=RbbCode::Schema.new
      Bbcode.all.each do |b|
        name="html_from_#{b.tag}_tag"
        name=name.to_sym
        self.class.send :define_method,name do |node|
          text=node.children.inject('') do |o,c|
            o+make_html(c)
          end
          inner=''
          inner=b.value.gsub '?',node.value.gsub(/^('|")(.+)\1$/,'\2') unless b.value.eql? '' || node.value.nil?
          inner+=b.inner.gsub '?',text unless b.inner.eql? ''
          b.layout.gsub '?',inner
        end
        @schema.allow_tag b.tag
        @schema.tag(b.tag).may_contain_text unless (b.properties&1).zero?
        @schema.tag(b.tag).may_not_be_empty unless (b.properties&2).zero?
        @schema.tag(b.tag).may_not_be_nested unless (b.properties&4).zero?
        @schema.tag(b.tag).may_not_contain_text unless (b.properties&8).zero?
        @schema.tag(b.tag).must_be_empty unless (b.properties&16).zero?
        @schema.tag(b.tag).may_be_nested unless (b.properties&32).zero?
      end
=begin
    1 may_contain_text
    2 may_not_be_empty
    4 may_not_be_nested
    8 may_not_contain_text
    16 must_be_empty
    32 may_be_nested
=end
    end
  end
end
