module ActiveAdminHelper
  def switch_link path, resource, predicate
    if resource.respond_to?(predicate)
      content_tag(:span, "#{resource.send(predicate) ? 'YES' : 'NO' }",
        class: "switch status_tag #{resource.send(predicate) ? 'yes' : 'no' }",
        data: { url: path, id: resource.id })
    end
  end
end