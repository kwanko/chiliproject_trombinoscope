#-- encoding: UTF-8
# Trombinoscope plugin for Chiliproject
# Copyright (C) 2012  Arnauld NYAKU

require 'redmine'

# require all files in lib
Dir::foreach(File.join(File.dirname(__FILE__), 'lib')) do |file|
  next unless /\.rb$/ =~ file
  require file
end

Redmine::Plugin.register :chiliproject_trombinoscope_plugin do
  name 'Chiliproject  Trombinoscope plugin'
  author 'Arnauld NYAKU'
  description 'This is a Trombinoscope plugin for Chiliproject'
  version '0.0.1'
  url ''
  author_url 'mailto:arnauld.nyaku@c2bsa.com'

  project_module :trombinoscope do
    permission :manage_trombinoscope, {:trombinoscope => :manage_trombinoscope}, :public => false
    permission :view_trombinoscope, {:trombinoscope => :index}, :public => true
  end

  menu :top_menu, :trombinoscope, {:controller => 'trombinoscope', :action => 'index' }, :caption => :label_trombinoscope #, :if => Proc.new { User.current.allowed_to?(:manage_trombinoscope, nil, :global => true) }
  menu :project_menu, :trombinoscope, {:controller => 'trombinoscope', :action => 'index'}, :caption => :label_trombinoscope, :param => :project_id
end

data = File.join(File.dirname(__FILE__), 'data')
Paperclip::FaceCrop.detectors = {
        'OpenCV' =>  {
          :face => ["#{data}/opencv/haarcascades/haarcascade_frontalface_alt_tree.xml",
                    "#{data}/opencv/haarcascades/haarcascade_frontalface_alt.xml",
                    "#{data}/opencv/haarcascades/haarcascade_profileface.xml"]
        }
      }
      
