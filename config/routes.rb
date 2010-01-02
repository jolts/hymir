ActionController::Routing::Routes.draw do |map|
  # Static pages
  map.with_options :controller => :info,
                   :method     => :get do |info|
    info.about 'about', :action => :about
    # Add more static pages here
  end

  # Sessions
  map.signup 'signup',
    :controller => :users,
    :action     => :new,
    :method     => :get
  map.login  'login',
    :controller => :user_sessions,
    :action     => :new,
    :method     => :get
  map.logout 'logout',
    :controller => :user_sessions,
    :action     => :destroy,
    :method     => :delete
  map.resource  :user_sessions, :only => [:create]

  # Users
  map.resources :users, :only => [:new, :create]

  # Posts
  map.resources :posts

  # Other post related routes
  map.with_options :controller => :posts, :method => :get do |post|
    # Find posts by slug
    post.slug 'posts/:year/:month/:day/:slug', :action => :show

    # Tags
    post.tag  'posts/tag/:tag', :action => :tag

    # Archives
    post.archive_day 'posts/archive/:year/:month/:day',
      :action       => :archive,
      :requirements => {:year => /\d{4}/, :month => /\d{2}/, :day => /\d{2}/}
    post.archive_month 'posts/archive/:year/:month',
      :action       => :archive,
      :requirements => {:year => /\d{4}/, :month => /\d{2}/}
    post.archive_year 'posts/archive/:year',
      :action       => :archive,
      :requirements => {:year => /\d{4}/}
  end

  # Index page
  map.root :controller => :posts, :action => :index, :method => :get

  # Default routes as lowest priority
  map.connect ':controller/:action/:id.:format'
  map.connect ':controller/:action/:id'
end
