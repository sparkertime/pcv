ActionController::Routing::Routes.draw do |map|
  map.resources :mixes, :member => [:add_feed, :remove_feed]

  map.resources :users

  map.resources :feeds, :only => [:index, :show]

  map.resources :feeds, :except => [:index, :show], :path_prefix => 'admin'

  map.resources :sessions, :only => [:new, :create]

  map.root :controller => :pages, :action => :home
end
