ActionController::Routing::Routes.draw do |map|
  map.signup 'signup', :controller => 'users', :action => 'new'
  map.login 'login', :controller => 'user_sessions', :action => 'new'
  map.logout 'logout', :controller => 'user_sessions', :action => 'destroy'

  map.resources :users, :only => [:new, :create]
  map.resource :user_sessions, :only => [:new, :create, :destroy]

  map.resources :posts
  map.slug 'posts/:year/:month/:day/:slug', :controller => 'posts', :action => 'show'
  map.archive 'archive/:year/:month/:day', :controller => 'posts', :action => 'archive'
  map.tag 'tag/:tag', :controller => 'posts', :action => 'tag'

  map.root :posts
end
