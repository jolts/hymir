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
  map.with_options :controller => :user_sessions do |session|
    session.login 'login', :action => :new, :method => :get
    session.logout 'logout', :action => :destroy, :method => :delete
  end
  map.resource  :user_sessions, :only => [:create]

  # Users
  map.resources :users, :except => [:show, :edit, :update]

  # Posts
  map.resources :posts do |post|
    post.resources :comments, :only => [:create, :destroy]
  end
  map.with_options :controller => :posts,
                   :method => :get do |post|
    # Tags
    post.tag  'tag/:tag', :action => :tag

    # Archives
    # FIXME: GET /archive/2010/01/01 (example) matches post.slug route!
    #        Should return 404 instead.
    post.archive_month 'archive/:year/:month',
      :action       => :archive,
      :requirements => {:year => /\d{4}/, :month => /\d{2}/}

    # Search
    post.search 'search', :action => :search

    # Find posts by slug
    post.slug ':year/:month/:day/:slug.:format', :action => :show
  end

  # Index page
  map.root :controller => :posts, :action => :index, :method => :get

  # Default routes as lowest priority
  map.connect ':controller/:action/:id.:format'
  map.connect ':controller/:action/:id'
end
