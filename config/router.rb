# This file is here so slice can be testing as a stand alone application.

Merb::Router.prepare do |r|
  
  r.resources :pages,   :controller => "resources/page"
  r.resources :widgets, :controller => "resources/widget"
  r.resources :formats, :controller => "resources/format"
  
end