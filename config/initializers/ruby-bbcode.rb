module RubyBBCode
  if @@tags
    @@tags[:spoiler] = {
      :html_open => '<span class="spoiler">',
      :html_close => '</span>',
      :description => 'Spoilered text',
      :example => 'super [spoiler]secret[/spoiler].'
    }
    @@tags[:quote] = {
      :html_open => '<div class="quote">%author%<blockquote>',
      :html_close => '</blockquote></div>',
      :description => 'Quote another person',
      :example => '[quote]BBCode is great[/quote]',
      :allow_tag_param => true,
      :allow_tag_param_between => false,
      :tag_param => /(.*)/,
      :tag_param_tokens => [{:token => :author, :prefix => '<p><cite>', :postfix => '</cite></p>'}]
    }
  end
end
