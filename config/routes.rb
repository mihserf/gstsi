ActionController::Routing::Routes.draw do |map|
 
 map.admin_login 'admin', :controller => 'admin', :action => 'index'
 map.admin_login 'admin/login', :controller => 'admin', :action => 'login'
 map.admin_logout 'admin/logout', :controller => 'admin', :action => 'logout'
 

 map.resources :countries, :has_many  => :cities
 # map.resources :cities

  
  map.with_options :path_prefix => ':lang', :lang => /ru|en|ua/, :name_prefix => 'lang_', :collection => {:list => :get} do |l|
    l.resources :pages
    l.resources :countries, :has_many  => :cities
    l.resources :cities, :has_many => :members
    l.resources :opinions
    l.resources :members, :has_many => [:statuses,:member_events], :has_one => [:story, :success_story, :opinion, :trainer_experience]
    l.resources :member_events
    l.resources :stories
    l.resources :success_stories
    l.resources :trainer_experiences
    l.resources :statuses, :has_many => :members
    l.resources :events
    l.resources :articles
    l.resources :charities
    l.resources :jim_articles
    l.resources :projects
    l.resources :albums
    l.resources :magazines, :has_many => :articles
    l.resources :time_tables
    l.resources :trainings
  end


  map.resources :pages
  map.resources :countries, :has_many  => :cities
  map.resources :cities, :has_many => :members
  map.resources :opinions
  map.resources :members, :has_many => [:statuses,:member_events], :has_one => [:story, :success_story, :opinion, :trainer_experience]
  map.resources :member_events
  map.resources :stories
  map.resources :success_stories
  map.resources :trainer_experiences
  map.resources :statuses, :has_many => :members
  map.resources :events
  map.resources :articles
  map.resources :charities
  map.resources :jim_articles
  map.resources :projects
  map.resources :albums
  map.resources :city_photos
  map.resources :project_photos
  map.resources :album_photos
  map.resources :magazines, :has_many => :articles
  map.resources :time_tables
  map.resources :trainings

  map.with_options :controller => "pages" do |page|
    page.home "/", :action =>  "home"
    ["about_us","contacts","faq","founder","team","mission","principles","london"].each do |action|  page.home "/#{action}", :action =>action   end
    page.home ":lang/", :action =>  "home", :lang => /ru|en|ua/
    page.home ":lang/:action"

  end

  

  

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

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  # map.root :controller => "welcome"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
