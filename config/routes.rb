ActionController::Routing::Routes.draw do |map|
  map.signup 'signup', :controller => 'users', :action => 'new'
  map.login 'login', :controller => 'user_sessions', :action => 'new'
  map.logout 'logout', :controller => 'user_sessions', :action => 'destroy'

  map.slugged_post 'posts/:year/:month/:day/:slug', :controller => 'posts', :action => 'show'

  map.resources :users, :only => [:new, :create]
  map.resources :user_sessions, :only => [:new, :create, :destroy]

  map.resources :posts do |post|
    post.resources :comments
  end

  map.root :posts
end
