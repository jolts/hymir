ActionController::Routing::Routes.draw do |map|
  # Static pages
  map.with_options :controller => :info,
                   :method     => :get do |info|
    info.about 'about', :action => :about
    info.portfolio 'portfolio', :action => :portfolio
    info.services 'services', :action => :services
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
  #map.resources :posts do |post|
  #  post.resources :comments, :only => [:create, :destroy]
  #end

  # Other post related routes
  map.with_options :controller => :posts,
                   :method => :get do |post|
    # Find posts by slug
    post.slug ':year/:month/:day/:slug', :action => :show

    # Tags
    post.tag  'tag/:tag', :action => :tag

    # Archives
    post.archive_day 'archive/:year/:month/:day',
      :action       => :archive,
      :requirements => {:year => /\d{4}/, :month => /\d{2}/, :day => /\d{2}/}
    post.archive_month 'archive/:year/:month',
      :action       => :archive,
      :requirements => {:year => /\d{4}/, :month => /\d{2}/}
    post.archive_year 'archive/:year',
      :action       => :archive,
      :requirements => {:year => /\d{4}/}
  end

  # Index page
  map.root :controller => :posts, :action => :index, :method => :get

  # Default routes as lowest priority
  map.connect ':controller/:action/:id.:format'
  map.connect ':controller/:action/:id'
end
