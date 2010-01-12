module UsersHelper
  def users_list_classes(users, user)
    if users.first == users.last
      cls = ' single'
    else
      cls = ' first' if user == users.first
      cls = ' last'  if user == users.last
    end

    cls.blank? ? nil : cls
  end
end
