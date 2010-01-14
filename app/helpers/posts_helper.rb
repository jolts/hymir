module PostsHelper
  def tag_paths(tags)
    tags.map {|tag| link_to h(tag), tag_path(tag)}.to_sentence
  end

  def archive_path(posts)
    time  = posts.map(&:created_at).first
    year  = time.strftime('%Y')
    month = time.strftime('%m')
    archives_path(year, month)
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

  def published?
    signed_in? ? {} : {:published => true}
  end
end
