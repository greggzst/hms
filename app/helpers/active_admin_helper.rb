module ActiveAdminHelper
  def switch_link path, resource, predicate
    if resource.respond_to?(predicate)
      content_tag(:span, "#{resource.send(predicate) ? 'TAK' : 'NIE' }",
        class: "switch status_tag #{resource.send(predicate) ? 'yes' : 'no' }",
        data: { url: path })
    end
  end
end