module PostsHelper
  def tag_urls(tags)
    tags.map {|tag| link_to tag, tag_url(tag)}.join(', ')
  end
end
