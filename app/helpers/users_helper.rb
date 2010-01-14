module UsersHelper
  def users_list_classes(users, user)
    cls = user.id == current_user.id ? ' self' : ''
    if users.first == users.last
      cls += ' single'
    else
      cls += ' first' if user == users.first
      cls += ' last'  if user == users.last
    end

    cls.blank? ? nil : cls
  end
end
