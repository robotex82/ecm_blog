Ecm::Blog.configure do |config|
  # Set the base controller for the controllers
  #
  # Default: config.base_controller = '::FrontendController'
  #
  config.base_controller = '::FrontendController'
  
  config.creator_class_name = 'User'
end
