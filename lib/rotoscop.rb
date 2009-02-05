if defined?(Merb::Plugins)

  $:.unshift File.dirname(__FILE__)

  dependency 'merb-slices', :immediate => true
  Merb::Plugins.add_rakefiles "rotoscop/merbtasks", "rotoscop/slicetasks", "rotoscop/spectasks"

  # Register the Slice for the current host application
  Merb::Slices::register(__FILE__)
  
  # Slice configuration - set this in a before_app_loads callback.
  # By default a Slice uses its own layout, so you can swicht to 
  # the main application layout or no layout at all if needed.
  # 
  # Configuration options:
  # :layout - the layout to use; defaults to :rotoscop
  # :mirror - which path component types to use on copy operations; defaults to all
  Merb::Slices::config[:rotoscop][:layout] ||= :rotoscop
  
  # All Slice code is expected to be namespaced inside a module
  module Rotoscop
    
    # Slice metadata
    self.description = "Rotoscop is a minimalistic CMS that allows you to create pages and put elements inside this page, with different styles and format."
    self.version = "1.0.0"
    self.author = "Legodata"
    
    # Stub classes loaded hook - runs before LoadClasses BootLoader
    # right after a slice's classes have been loaded internally.
    def self.loaded
      ::Rotoscop::Helpers.setup
    end
    
    # Initialization hook - runs before AfterAppLoads BootLoader
    def self.init
    end
    
    # Activation hook - runs after AfterAppLoads BootLoader
    def self.activate
    end
    
    # Deactivation hook - triggered by Merb::Slices.deactivate(Rotoscop)
    def self.deactivate
    end
    
    # Setup routes inside the host application
    #
    # @param scope<Merb::Router::Behaviour>
    #  Routes will be added within this scope (namespace). In fact, any 
    #  router behaviour is a valid namespace, so you can attach
    #  routes at any level of your router setup.
    #
    # @note prefix your named routes with :rotoscop_
    #   to avoid potential conflicts with global named routes.
    def self.setup_router(scope)
      ::Rotoscop::Router.setup(scope)
    end
    
  end
  
  # Setup the slice layout for Rotoscop
  #
  # Use Rotoscop.push_path and Rotoscop.push_app_path
  # to set paths to rotoscop-level and app-level paths. Example:
  #
  # Rotoscop.push_path(:application, Rotoscop.root)
  # Rotoscop.push_app_path(:application, Merb.root / 'slices' / 'rotoscop')
  # ...
  #
  # Any component path that hasn't been set will default to Rotoscop.root
  #
  # Or just call setup_default_structure! to setup a basic Merb MVC structure.
  Rotoscop.setup_default_structure!
  
  use_orm :datamapper
  
  merb_version = ">= 1.0.7.1"
  dependency 'merb-assets',     merb_version
  dependency 'merb-helpers',    merb_version
  dependency 'merb_datamapper', merb_version
  dependency 'merb-builder', "0.9.8"
  
  dm_gems_version   = ">= 0.9.9"
  dependency "dm-core", dm_gems_version         
  dependency "dm-aggregates", dm_gems_version   
  dependency "dm-migrations", dm_gems_version   
  dependency "dm-timestamps", dm_gems_version   
  dependency "dm-types", dm_gems_version        
  dependency "dm-validations", dm_gems_version
  dependency "dm-tags", dm_gems_version
  dependency "dm-is-tree", dm_gems_version
  
  dependency "haml", ">=2.1.0" 
  dependency "merb-haml", merb_version
  dependency "chriseppstein-compass", :require_as => 'compass'
  
  # Add dependencies for other Rotoscop classes below.
  require "rotoscop/helpers"
  require "rotoscop/router"
  
end