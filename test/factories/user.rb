Factory.define(:user) do |u|
  u.username 'John Doe'
  u.email 'john@doe.com'
  u.password 'abcdef'
  u.password_confirmation 'abcdef'
  u.roles ['admin']
end
