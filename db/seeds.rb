# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#   
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Major.create(:name => 'Daley', :city => cities.first)

admin_user = User.new(
  :username => 'admin',
  :email => Hymir::Config[:email],
  :password => 'abcdef',
  :password_confirmation => 'abcdef',
  :roles => ['admin']
)

puts 'Successfully created admin user' if admin_user.save!

welcome_post = Post.new(
  :user_id => admin_user.id,
  :creator_id => admin_user.id,
  :title => 'Welcome to Hymir!',
  :body => 'Should be more stuff here&hellip;',
  :tags => ['welcome', 'hymir'],
  :created_at => Time.now,
  :updated_at => Time.now
)

puts 'Successfully created welcome post' if welcome_post.save!

about_page = Page.new(
  :user_id => admin_user.id,
  :creator_id => admin_user.id,
  :title => 'About',
  :body => 'Fill me',
  :url => 'about',
  :created_at => Time.now,
  :updated_at => Time.now
)

puts 'Successfully created about page' if about_page.save!
