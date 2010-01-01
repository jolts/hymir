ActionController::Routing::Routes.draw do |map|
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
  map.resources :posts, :member => {:tag => :get} # :archive => :get

  # Find posts by slug
  map.slug 'posts/:year/:month/:day/:slug',
    :controller => :posts,
    :action     => :show

  # Tags
  map.tag 'tag/:tag',
    :controller => :posts,
    :action => :tag

  # Archives
  # TODO: Implement this
=begin
  map.archive_day 'archive/:year/:month/:day',
    :controller => :posts,
    :action     => :archive
  map.archive_month 'archive/:year/:month',
    :controller => :posts,
    :action     => :archive
  map.archive_year 'archive/:year',
    :controller => :posts,
    :action     => :archive
  map.archive 'archive',
    :controller => :posts,
    :action     => :archive
=end

  map.root :controller => :posts, :action => :index
end
