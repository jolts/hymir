module PostsHelper
  def tag_paths(tags)
    tags.map {|tag| link_to tag, tag_path(tag)}.join(', ')
  end

  def post_slug_path(post)
    slug_path(
      post.slug,
      'html'
    )
  end

  def archive_path(posts)
    year  = posts.map {|p| p.created_at.strftime('%Y')}.first
    month = posts.map {|p| p.created_at.strftime('%m')}.first
    "/archive/#{year}/#{month}"
  end

  def user_role(user)
    role = 'Author' if user.role?(:author)
    role = 'Moderator' if user.role?(:moderator)
    role = 'Admin' if user.role?(:admin)
    role ||= ''
  end

  def first_or_last_post(post)
    if @posts.first == @posts.last
      cls = ' single'
    else
      cls = ' first' if post == @posts.first
      cls = ' last'  if post == @posts.last
    end
    cls ||= ''
  end
end
