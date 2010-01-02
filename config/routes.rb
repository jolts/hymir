ActionController::Routing::Routes.draw do |map|
  # Static pages
  map.with_options :controller => :info,
                   :conditions => {:method => :get} do |info|
    info.about 'about', :action => :about
    # Add more static pages here
  end

  # Sessions
  map.signup 'signup', :controller => :users, :action => :new
  map.login  'login',  :controller => :user_sessions, :action => :new
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
    :conditions => {:method => :get}

  # Tags
  map.tag 'tag/:tag',
    :controller => :posts,
    :action     => :tag,
    :conditions => {:method => :get}

  # Archives
  # TODO: Implement this
  map.with_options :controller => :posts,
                   :action     => :archive,
                   :conditions => {:method => :get} do |archive|
    archive.day   'archive/:year/:month/:day'
    archive.month 'archive/:year/:month'
    archive.year  'archive/:year'
  end

  # Index page
  map.root :controller => :posts, :action => :index

  # Default routes as lowest priority
  map.connect ':controller/:action/:id.:format'
  map.connect ':controller/:action/:id'
end
