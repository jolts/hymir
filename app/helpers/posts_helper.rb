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
    cls = ''

    if posts.first.id == posts.last.id
      cls += ' alone'
    else
      cls += ' first' if post.id == posts.first.id
      cls += ' last'  if post.id == posts.last.id
    end
    cls += ' draft' if not post.published

    cls.blank? ? nil : cls
  end

  def published?
    signed_in? ? {} : {:published => true}
  end
end
