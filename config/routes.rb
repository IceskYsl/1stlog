ActionController::Routing::Routes.draw do |map|
  # The priority is based upon order of creation: first created -> highest priority.
  
  # Sample of regular route:
  # map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  # map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  #后台管理需要的URL
  map.namespace(:admin) do |admin|
    admin.resources :categories, :has_many   => [ :topics, :comments ] ,:collection=>{:list => :get}
    admin.resources :natures,
      :has_one   => [   :topics, :comments ] 
    admin.resources  :topics,:collection=>{:list => :get}
    admin.resources  :comments,:collection=>{:list => :get,:deleteall => :get,:showall => :get,:hidenall => :get}
    admin.resources  :trcakbacks,:collection=>{:list => :get,:deleteall => :get,:showall => :get,:hidenall => :get}
    admin.resources  :tags
    admin.resources  :users
    admin.resources  :themes,:collection=>{:list => :get,:preview => :get,:active =>:get}
    admin.resources  :links,:collection=>{:list => :get}
    admin.resources  :configurations
    admin.resources  :attachments
    admin.resources  :plugins
    admin.resources  :caches,:collection=>{:counts => :get}
     admin.resources  :logs,:collection=>{:counts => :get}
  end

  #前台
  map.resources :categories do |category|
    category.resources :topics
  end
  
  map.resources :natures do |nature|
    nature.resources :topics
  end

#  map.resources :archives do |archive|
#    archive.resources :topics
#  end
  

  
  # You can have the root of your site routed by hooking up '' 
  # -- just remember to delete public/index.html.
  # map.connect '', :controller => "welcome"

  # Allow downloading Web Service WSDL as a file with an extension
  # instead of a file named 'wsdl'

   
  map.connect ':controller/service.wsdl', :action => 'wsdl'
  map.connect '/topic/code_image', :controller => 'topic', :action => 'code_image'
   
  map.connect 'theme/:theme/:id/',:controller => "index",:action=>"theme"
  map.root :controller => "index"
  map.connect '/topic/:id', :controller => 'topic', :action => 'index'

  
  map.connect '/category/:id', :controller => 'category', :action => 'index'
  map.connect '/trackback/:id', :controller => 'trackback', :action => 'index'
  map.connect '/tag/:id', :controller => 'tag', :action => 'index'
#  map.connect '/nature/:id', :controller => 'nature', :action => 'index'
  
  
  map.connect 'archives/:year/:month',:controller => 'archives',
    :action => 'show',
    :year => /\d{4}/, :day => nil, :month => nil
  map.connect 'archives/:year/:month/:day/:title', :controller => 'archives',
    :action => 'permalink', :year => /\d{4}/
  map.connect '/configuration/preview/:theme',:controller => 'admin/configuration',:action => 'preview'

  # Install the default route as the lowest priority.
  map.connect ':controller/:action/:id.:format'
  map.connect ':controller/:action/:id'
  #TinyMceGzip::Routes.add_routes
  #  map.theme_images "/themes/:theme/images/*filename", :controller=>'theme', :action=>'images'
  #  map.theme_stylesheets "/themes/:theme/stylesheets/*filename", :controller=>'theme', :action=>'stylesheets'
  #  map.theme_javascript "/themes/:theme/javascript/*filename", :controller=>'theme', :action=>'javascript'

end
