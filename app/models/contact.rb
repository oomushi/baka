class Contact < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :type,:value
  
  def to_s
    case type
      when 'email' then mail_to value,"&thinsp;".html_safe, { :encode=>:javascript, :title=> value,:class=>"button email"}
      when 'website' then link_to value, "&thinsp;".html_safe, {class: 'website button', target: '_blank', title: t(:website).downcase}
    end
  end
end
