module ApplicationHelper

  def sanitize_category(unsanitized_category)
    return unsanitized_category.gsub(" ", "_").downcase()
  end

  def is_admin?
    current_user && current_user.is_role_by_name?('admin')
  end
end
