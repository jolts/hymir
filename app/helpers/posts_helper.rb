module PostsHelper
  def tag_urls(tags)
    tags.map {|tag| link_to tag, tag_url(tag)}.join(', ')
  end

  def post_slug_url(post)
    slug_path(
      post.created_at.year,
      post.created_at.month,
      post.created_at.day,
      post.slug
    )
  end

  def archive_url(posts)
    year  = posts.map {|p| p.created_at.year}.first
    month = posts.map {|p| p.created_at.month}.first
    "archive/#{year}/#{month < 10 ? "0#{month}" : month}"
  end

  def parse_markdown_body(body)
    RDiscount.new(body).to_html
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
