module ApplicationHelper
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
=begin
      bb=BBCode.all
=end
      @schema=RbbCode::Schema.new
      name="html_from_spoiler_tag"
      name=name.to_sym
      self.class.send :define_method,name do |node|
        text=node.children.inject('') do |o,c|
          o+make_html(c)
        end
        content_tag('span',text,{'class'=>'spoiler'})
      end
      @schema.allow_tag 'spoiler'
      @schema.tag('spoiler').may_contain_text.may_be_nested
    end
  end
end
