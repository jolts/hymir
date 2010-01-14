atom_feed do |feed|
  feed.title(Hymir::Config[:title])
  feed.updated(@posts.first.updated_at) if @posts.any?

  @posts.each do |post|
    feed.entry(post) do |entry|
      entry.title(post.title)
      entry.content(post.body, :type => 'html')
      entry.author {|author| author.name(post.user.username)}
    end
  end
end
