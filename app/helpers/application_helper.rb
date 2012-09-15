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
      # spoiler
      name="html_from_spoiler_tag"
      name=name.to_sym
      self.class.send :define_method,name do |node|
        text=node.children.inject('') do |o,c|
          o+make_html(c)
        end
        content_tag('span',text,{'class'=>'spoiler'})
      end
      @schema.allow_tag 'spoiler'
      @schema.tag('spoiler').may_contain_text.may_not_be_nested.may_be_nested.may_not_be_empty
      # quote
      name="html_from_quote_tag"
      name=name.to_sym
      self.class.send :define_method,name do |node|
        text=node.children.inject('') do |o,c|
          o+make_html(c)
        end
        inner=node.value.nil? ? '' : content_tag('legend',node.value.gsub(/^('|")(.+)\1$/,'\2'))
        inner+=content_tag('blockquote',text)
        content_tag('fieldset',inner)
      end
      @schema.allow_tag 'quote'
      @schema.tag('quote').may_contain_text.may_not_be_nested.may_be_nested.may_not_be_empty
      # :P
      name="html_from_P_tag"
      name=name.to_sym
      self.class.send :define_method,name do |node|
        text=node.children.inject('') do |o,c|
          o+make_html(c)
        end
        content_tag('img','',{'src'=>'/assets/p.png'})
      end
      @schema.allow_tag 'P'
      @schema.tag('P').may_not_be_nested.must_be_empty.may_be_nested
      # ::
      name="html_from_B_tag"
      name=name.to_sym
      self.class.send :define_method,name do |node|
        text=node.children.inject('') do |o,c|
          o+make_html(c)
        end
        content_tag('img','',{'src'=>'/assets/b.png'})
      end
      @schema.allow_tag 'B'
      @schema.tag('B').may_not_be_nested.must_be_empty.may_be_nested
=end
    end
  end
end
