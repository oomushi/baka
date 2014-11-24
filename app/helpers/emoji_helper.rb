module EmojiHelper
  def emojify(content)
    content=content.bbcode_to_html.html_safe unless content.nil?
    h(content).to_str.gsub(/:([\w+-]+):/) do |match|
      if emoji = Emoji.find_by_alias($1)
        %(<img alt="#$1" src="#{asset_path("emoji/#{emoji.image_filename}")}" style="vertical-align:middle" width="20" height="20" />)
      else
        match
      end
    end.html_safe if content.present?
  end
  def emoji_range from, to
    ret=''
    (from..to).each do |c|
      ret<<link_to(emojify(":"+Emoji.find_by_unicode(c).name+":"),'javascript:void(0)',data: {:tag=>":"+Emoji.find_by_unicode(c).name+":"}) unless Emoji.find_by_unicode(c).nil?
    end
    ret.html_safe
  end
end
