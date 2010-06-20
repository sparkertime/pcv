ActionController::Routing::Routes.draw do |map|
  map.resources :feeds, :only => [:index, :show]

  map.resources :feeds, :except => [:index, :show], :path_prefix => 'admin'
end
