module PostsHelper
  def tag_urls(tags)
    tags.map {|tag| link_to tag, tag_path(tag)}.join(', ')
  end

  def post_slug_url(post)
    year  = post.created_at.year
    month = prepend_zero?(post.created_at.month)
    day   = prepend_zero?(post.created_at.day)
    slug_path(
      year,
      month,
      day,
      post.slug
    )
  end

  def archive_url(posts)
    year  = posts.map {|p| p.created_at.year}.first
    month = prepend_zero?(posts.map {|p| p.created_at.month}.first)
    "/archive/#{year}/#{month}"
  end

  def archive_title(params)
    date = params[:year]
    if params[:day]
      date += "/#{params[:month]}/#{params[:day]}"
    elsif params[:month]
      date += "/#{params[:month]}"
    end
    title "Posts from #{date}"
  end

  def user_role(user)
    role = ''
    role = 'Author' if user.role?(:author)
    role = 'Moderator' if user.role?(:moderator)
    role = 'Admin' if user.role?(:admin)
    role
  end

  def first_or_last_post(post)
    cls = ''
    if @posts.first == @posts.last
      cls = ' single'
    else
      cls = ' first' if post == @posts.first
      cls = ' last'  if post == @posts.last
    end
    cls
  end
end
