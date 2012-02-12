module ApplicationHelper
  def bb text
    bb = RbbCode::Parser.new
    bb.parse(text).html_safe
  end
end
