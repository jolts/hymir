user = User.create!(:username => 'admin',
                    :email => Hymir::Config[:email],
                    :password => 'abcdef',
                    :password_confirmation => 'abcdef')
puts 'Successfully created user'

Post.create!(:user_id => user.id,
             :creator_id => user.id,
             :title => 'Welcome to Hymir!',
             :body => 'Should be more stuff here&hellip;',
             :tags => ['welcome', 'hymir'],
             :created_at => Time.now,
             :updated_at => Time.now)
puts 'Successfully created welcome post'

Page.create!(:user_id => user.id,
             :creator_id => user.id,
             :title => 'About',
             :body => 'Fill me',
             :url => 'about',
             :created_at => Time.now,
             :updated_at => Time.now)
puts 'Successfully created about page'
