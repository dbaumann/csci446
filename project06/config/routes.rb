ActionController::Routing::Routes.draw do |map|
  
  map.login "login", :controller => 'user_sessions', :action => 'new'
  map.logout "logout", :controller => 'user_sessions', :action => 'destroy'
  
  map.resources :user_sessions, :only => [:new, :create, :destroy]
  
  map.namespace :admin do |admin|
    admin.resources :roles
    admin.resources :users
    admin.resources :games
    admin.root :controller => 'admin', :action => 'index'
  end
  
  map.namespace :members do |members|
    members.resources :users
    members.resources :games
    members.root :controller => 'members', :action => 'index'
  end
  
  #site root
  map.root :controller => "games"
  
  map.resources :users
  map.resources :roles  #no idea why the app breaks when I remove this
  map.resources :games

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing or commenting them out if you're using named routes and resources.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
