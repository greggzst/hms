module ApplicationHelper
  def boolean_tag(predicate)
    predicate ? 'YES' : 'NO'
  end
end
