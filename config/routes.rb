ActionController::Routing::Routes.draw do |map|
  # Static pages
  map.with_options :controller => :info, :conditions => {:method => :get} do |info|
    info.about 'about', :action => :about
    info.portfolio 'portfolio', :action => :portfolio
    info.services 'services', :action => :services
  end

  # Sessions
  map.resource :user_sessions, :only => [:create]
  map.with_options :controller => :user_sessions do |session|
    session.login 'login', :action => :new, :conditions => {:method => :get}
    session.logout 'logout', :action => :destroy, :conditions => {:method => :delete}
    session.forgot_password 'forgot_password', :action => :forgot_password, :conditions => {:method => :post}
  end

  # Users
  map.resources :users, :except => [:show]
  map.reset_password 'reset_password/:reset_code', :controller => :users, :action => :reset_password, :conditions => {:method => :get}

  # Posts
  map.resources :posts do |post|
    post.resources :comments, :only => [:create, :destroy]
  end
  map.with_options :controller => :posts, :conditions => {:method => :get} do |post|
    post.tag 'tag/:tag', :action => :tag, :tag => /[A-Z\s\-%20]+/i
    post.archives 'archives/:year/:month', :action => :archive, :year => /[0-9]{4}/, :month => /[0-9]{1,2}/
  end

  # Index page
  map.root :controller => :posts, :action => :index, :conditions => {:method => :get}
end
