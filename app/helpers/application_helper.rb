module ApplicationHelper
  def link_to_void name, params
    link_to name,'javascript:void(0)', params
  end
end
