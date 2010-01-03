module PostsHelper
  def tag_urls(tags)
    tags.map {|tag| link_to tag, tag_url(tag)}.join(', ')
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
    "archive/#{year}/#{month}"
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
end
