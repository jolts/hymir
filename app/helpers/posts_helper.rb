module PostsHelper
  def tag_paths(tags)
    tags.map {|tag| link_to tag, tag_path(tag)}.join(', ')
  end

  def archive_path(posts)
    year  = posts.map {|p| p.created_at.strftime('%Y')}.first
    month = posts.map {|p| p.created_at.strftime('%m')}.first
    archives_path(year, month)
  end

  def user_role(user)
    role = 'Author' if user.role?(:author)
    role = 'Moderator' if user.role?(:moderator)
    role = 'Admin' if user.role?(:admin)
    role ||= ''
  end

  def posts_list_classes(posts, post)
    cls = post.published ? '' : ' draft'
    if posts.first == posts.last
      cls += ' single'
    else
      cls += ' first' if post == posts.first
      cls += ' last'  if post == posts.last
    end

    cls.blank? ? nil : cls
  end
end
