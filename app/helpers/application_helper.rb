module ApplicationHelper
  def is_admin?
    current_user && current_user.is_role_by_name?('admin')
  end
end
