module Rotoscop
  module Router
    
    def self.setup(scope)
      scope.match('/').to(:controller => 'main', :action => 'index').name(:index)
    end
    
  end
end