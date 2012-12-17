#-- encoding: UTF-8
#custom routes for this plugin
ActionController::Routing::Routes.draw do |map|
    map.connect 'trombinoscope', :controller => 'trombinoscope', :action => 'index'
    map.connect 'projects/:project_id/trombinoscope', :controller => 'trombinoscope', :action => 'index'
end