module ApplicationHelper
  def bb text
    if ! text.nil? and text!=''
      bb = RbbCode::Parser.new
      bb.parse(text).html_safe
    end
  end
end
