ActionController::Routing::Routes.draw do |map|
  # Static pages
  map.with_options :controller => :info,
                   :method     => :get do |info|
    info.about 'about', :action => :about
    info.portfolio 'portfolio', :action => :portfolio
    info.services 'services', :action => :services
  end

  # Sessions
  map.with_options :controller => :user_sessions do |session|
    session.login 'login', :action => :new, :method => :get
    session.logout 'logout', :action => :destroy, :method => :delete
  end
  map.resource :user_sessions, :only => [:create]

  # Users
  map.resources :users, :except => [:show, :edit, :update]

  # Posts
  map.resources :posts do |post|
    post.resources :comments, :only => [:create, :destroy]
  end
  map.with_options :controller => :posts,
                   :method     => :get do |post|
    # Tags
    post.tag 'posts/tag/:tag',
             :action => :tag,
             :tag => /[A-Z\-]+/i

    # Archives
    post.archives 'posts/archive/:year/:month',
                  :action => :archive,
                  :year   => /\d{4}/,
                  :month  => /\d{2}/
  end

  # Index page
  map.root :controller => :posts, :action => :index, :method => :get
end
