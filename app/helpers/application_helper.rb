module ApplicationHelper
  def bb text
    if ! text.nil? and text!=''
      cc=CCParser.instance
      logger.debug cc.inspect
      bb = RbbCode::Parser.new(:html_maker=>cc)
      bb.parse(text).html_safe+cc.methods.sort.inspect
    end
  end
  private
  class CCParser < RbbCode::HtmlMaker # Singleton
    include Singleton
    private
    def initialize
=begin
      bb=BBCode.all
=end
      name="html_from_query_tag"
      name=name.to_sym
      send :define_method, name do |node|
        "<span class=\"cit\">#{node.inspect}</span>"
      end
    end
  end
end
