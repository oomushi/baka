module MessagesHelper
  def del_subobject_div(name, f, options={})
    f.hidden_field(:_destroy,{:disabled=>true}) + link_to_void(name, :data=>{:unique=>options[:unique]}, :class=>"remove_subobj")
  end
  def new_subobject_div(name, f, association, options={})
    new_object = f.object.class.reflect_on_association(association).klass.new
    id="new_#{association}"
    fields = f.fields_for(association, new_object, :child_index => id) do |builder|
      render( :partial => association.to_s.pluralize + "/form", :locals=>{:f => builder, :disabled=>true})
    end
    content_tag(:p,link_to_void(name,:data=>{:rif=>id, :unique=>options[:unique]})) + content_tag( :template, fields, :id=>id)
  end
end
