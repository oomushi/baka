module MessagesHelper
  def link_to_remove_fields(name, f)
    f.hidden_field(:_destroy) + link_to_function(name, "remove_fields(this)")
  end
  
  def link_to_remove_unique_fields(name, f)
    f.hidden_field(:_destroy) + link_to_function(name, "unique_remove(this);remove_fields(this)")
  end
  def link_to_add_unique_fields(name,f,association,klass) 
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render(association.to_s.pluralize + "/form", :f => builder)
    end
    link_to_function(name, "unique_add(this, \"#{association}\", \"#{escape_javascript(fields)}\")",:class => klass)
  end
  def link_to_add_fields(name, f, association)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render(association.to_s.pluralize + "/form", :f => builder)
    end
    link_to_function(name, "add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")")
  end
end
