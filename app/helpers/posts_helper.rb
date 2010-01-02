module PostsHelper
  def tag_urls(tags)
    tags.map {|tag| link_to tag, tag_url(tag)}.join(', ')
  end

  def post_slug_url(post)
    slug_url(
      post.created_at.year,
      post.created_at.month,
      post.created_at.day,
      post.slug
    )
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
