Factory.define(:post) do |p|
  p.user_id { |u| u.association(:user).id }
  p.title 'Foo bar baz'
  p.body 'Hello World'
  p.named_tags 'foo; bar; baz'
end
