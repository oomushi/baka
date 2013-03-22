module MessagesHelper
  def link_to_remove_fields(name, f)
    f.hidden_field(:_destroy,{:disabled=>true}) + link_to_function(name, "remove_fields(this)")
  end
  
  def link_to_remove_unique_fields(name, f)
    f.hidden_field(:_destroy,{:disabled=>true}) + link_to_function(name, "unique_remove(this);remove_fields(this)")
  end

  def new_subobject_div(name, f, association, options={})
    new_object = f.object.class.reflect_on_association(association).klass.new
    id="new_#{association}"
    fields = f.fields_for(association, new_object, :child_index => id) do |builder|
      render( :partial => association.to_s.pluralize + "/form", :locals=>{:f => builder, :disabled=>true})
    end
    content_tag(:p,link_to(name,'javascript:void(0)',:data=>{:rif=>id, :unique=>options[:unique]})) << content_tag( :span, fields, :class=>"form_example", :id=>id)
  end
end
