ActionController::Routing::Routes.draw do |map|
  # Static pages
  map.with_options :controller => :info,
                   :conditions => {:method => :get} do |info|
    info.about 'about', :action => :about
    info.portfolio 'portfolio', :action => :portfolio
    info.services 'services', :action => :services
  end

  # Sessions
  map.with_options :controller => :user_sessions do |session|
    session.login 'login', :action => :new, :conditions => {:method => :get}
    session.logout 'logout', :action => :destroy, :conditions => {:method => :delete}
  end
  map.resource :user_sessions, :only => [:create]

  # Users
  map.resources :users, :except => [:show]
  map.with_options :controller => :users do |users|
    users.forgot_password 'forgot_password',
                          :action => :forgot_password,
                          :conditions => {:method => :post}
    users.reset_password 'reset_password/:reset_code',
                         :action => :reset_password,
                         :conditions => {:method => :get}
  end

  # Posts
  map.resources :posts do |post|
    post.resources :comments, :only => [:create, :destroy]
  end
  map.with_options :controller => :posts,
                   :conditions => {:method => :get} do |post|
    # Tags
    post.tag 'posts/tag/:tag',
             :action => :tag,
             :tag => /[A-Z\s\-]+/i
    # Archives
    post.archives 'posts/archives/:year/:month',
                  :action => :archive,
                  :year   => /[0-9]{4}/,
                  :month  => /[0-9]{1,2}/
  end

  # Index page
  map.root :controller => :posts, :action => :index, :conditions => {:method => :get}
end
