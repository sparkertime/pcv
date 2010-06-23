ActionController::Routing::Routes.draw do |map|
  map.resources :mixes, :member => [:add_feed, :remove_feed]

  map.resources :users

  map.resources :feeds, :only => [:index, :show]
  
  map.namespace :admin do |admin|
    admin.resources :feeds, :except => [:index, :show]
  end

  map.resources :sessions, :only => [:new, :create], :collection => {:end => :post}

  map.admin '/admin', :controller => :sessions, :action => :new

  map.root :controller => :pages, :action => :home
end
