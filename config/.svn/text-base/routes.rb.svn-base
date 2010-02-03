ActionController::Routing::Routes.draw do |map|
  map.resources :settings

  map.resources :mailings

  map.resources :feeds
  map.root :controller => 'feeds', :action => 'show_feeds'
  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  # map.root :controller => "welcome"

  # See how all your routes lay out with "rake routes"
  
   map.with_options :controller => 'feeds' do |f|
       f.show_feeds '/show_feeds', :action => 'show_feeds'
       f.mark_feeds '/mark_feeds', :action => 'mark_feeds'
       f.show_all_feeds '/show_all_feeds', :action => 'show_all_feeds'
       f.show_feed '/show_post/:id', :action => 'show_post'
       f.remote_show_post '/remote_show_post/:id/:called_from',  :action => 'remote_show_post'
       f.clear_old '/clear_old', :action => 'purge'
   end
   
   map.with_options :controller => 'settings' do |s|
     s.settings '/settings', :action => 'index'
   end

  # Install the default routes as the lowest priority.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
