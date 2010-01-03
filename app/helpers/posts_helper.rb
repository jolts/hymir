module PostsHelper
  def tag_urls(tags)
    tags.map {|tag| link_to tag, tag_url(tag)}.join(', ')
  end

  def post_slug_url(post)
    year  = post.created_at.year
    month = post.created_at.month
    day   = post.created_at.day
    slug_path(
      year,
      month < 10 ? "0#{month}" : month,
      day < 10 ? "0#{day}" : day,
      post.slug
    )
  end

  def archive_url(posts)
    year  = posts.map {|p| p.created_at.year}.first
    month = posts.map {|p| p.created_at.month}.first
    "archive/#{year}/#{month < 10 ? "0#{month}" : month}"
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
