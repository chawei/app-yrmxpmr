ActionController::Routing::Routes.draw do |map|
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
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end
  map.home '/', :controller => 'home', :action => 'index'
  map.resources :categories
  map.resources :projects
  map.resources :x5ers
  map.resource  :session
  
  map.client_logout '/logout', :controller => 'sessions', :action => 'destroy'
  map.logout '/admin/logout', :controller => 'admin/sessions', :action => 'destroy'
  map.login '/admin/login', :controller => 'admin/sessions', :action => 'new'
  map.register '/admin/register', :controller => 'admin/users', :action => 'create'
  map.signup '/admin/signup', :controller => 'admin/users', :action => 'new'
  
  map.admin_home '/admin', :controller => 'admin/projects', :action => 'index'
  
  map.namespace :admin do |admin|
    admin.resources :categories, :collection => { :sort => :post, :toggle_published => :post }
    admin.resources :projects, :collection => { :sort => :post, 
                                                :toggle_published => :post, 
                                                :delete_photo => :delete }
    admin.resources :photos, :collection => { :sort => :post, :delete_photo => :delete }
    admin.resources :pages
    admin.resources :lines
    admin.resources :users
    admin.resources :x5ers
    admin.resources :clients
    admin.resource  :session
  end
  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  # map.root :controller => "welcome"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing or commenting them out if you're using named routes and resources.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
