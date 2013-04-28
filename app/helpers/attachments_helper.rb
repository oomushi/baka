module AttachmentsHelper
  def new_attachment(name, f, association, options={})
    new_object = f.object.class.reflect_on_association(association).klass.new
    id="new_#{association}"
    f.fields_for(association, new_object, :child_index => id) do |builder|
      render( :partial => association.to_s.pluralize + "/form", :locals=>{:f => builder})
    end
  end
end
