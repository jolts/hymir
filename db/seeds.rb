# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#   
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Major.create(:name => 'Daley', :city => cities.first)

admin_user = User.create(
  :username => 'admin',
  :email => 'gigamo@gmail.com',
  :password => 'abcdef',
  :password_confirmation => 'abcdef',
  :roles_mask => '1'
)
admin_user.save!

welcome_post = Post.create(
  :user_id => admin_user.id,
  :title => 'Welcome to Hymir!',
  :tags => 'welcome; hymir',
  :body => 'Welcome to Hymir! Should be more stuff here...',
  :created_at => Time.now,
  :updated_at => Time.now
)
welcome_post.save!
