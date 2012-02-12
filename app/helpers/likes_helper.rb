module LikesHelper
  def link_to_submit text, params={}
    link_to_function text, "$(this).closest('form').submit()", params
  end
end
