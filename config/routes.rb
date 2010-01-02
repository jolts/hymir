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

  # Find posts by slug
  map.slug 'posts/:year/:month/:day/:slug',
    :controller => :posts,
    :action     => :show,
    :method     => :get

  # Tags
  map.tag 'tag/:tag',
    :controller => :posts,
    :action     => :tag,
    :method     => :get

  # Archives
  map.with_options :controller   => :posts,
                   :action       => :archive,
                   :requirements => {:year => /\d{4}/, :month => /\d{2}/, :day => /\d{2}/},
                   :method       => :get do |archive|
    archive.archive_day   'archive/:year/:month/:day'
    archive.archive_month 'archive/:year/:month'
    archive.archive_year  'archive/:year'
  end

  # Index page
  map.root :controller => :posts, :action => :index, :method => :get

  # Default routes as lowest priority
  map.connect ':controller/:action/:id.:format'
  map.connect ':controller/:action/:id'
end
