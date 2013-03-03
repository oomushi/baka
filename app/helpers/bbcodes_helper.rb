module BbcodesHelper
  def bb text
    if ! text.nil? and text!=''
      bb=MyBBCoder.new Sanitize.clean(text.to_s.gsub('<3','&lt;3'))
      bb.to_html.gsub(/\n|\r\n/, "<br />").html_safe
    end
  end
  private
  class MyBBCoder < BBCoder
    def initialize text
      if @@unconfig
#       BBCoder.configuration.clear
        BBCoder.configure do |bb|
          Bbcode.all.each do |b|
            if !b.tag.nil? && b.tag.length>0
              bb.tag b.tag.to_sym, :singular => b.singular, :match=>Regexp.new(b.match) do
                b.text.gsub('#{content}',content).gsub('#{meta}',meta)
              end
            end
          end
        end
        @@unconfig=false
      end
      super text
    end
    private
    @@unconfig=true
  end
end
