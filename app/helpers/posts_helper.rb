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
end
