module BbcodesHelper
  def bb text
    if ! text.nil? and text!=''
      bb=MyBBCoder.instance
      bb.text=Sanitize.clean(text.to_s)
      bb.to_html.gsub(/\n|\r\n/, "<br />").html_safe
    end
  end
  private
  class MyBBCoder < BBCoder # Singleton
    include Singleton
    alias :text= :initialize
    def initialize
#     BBCoder.configuration.clear
      BBCoder.configure do |bb|
        Bbcode.all.each do |b|
          if !b.tag.nil? && b.tag.length>0
            bb.tag b.tag.to_sym, :singular => b.singular, :match=>Regexp.new(b.match) do
              b.text.gsub('#{content}',content).gsub('#{meta}',meta)
            end
          end
        end
      end
    end
    public :text=
  end
end
