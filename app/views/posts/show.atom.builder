atom_feed do |feed|
  feed.title(@post.title)
  feed.updated(@post.comments.last.created_at)

  @post.comments.sort_by {|c| c.created_at}.each do |comment|
    feed.entry(@post) do |entry|
      entry.title(truncate(comment.body, 40))
      entry.content(comment.body, :type => 'html')
      entry.author {|author| author.name(comment.name)}
    end
  end
end
