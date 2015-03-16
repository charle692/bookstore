module ApplicationHelper
  def sanitize_category(unsanitized_category)
    return unsanitized_category.gsub(" ", "_").downcase()
  end
end
