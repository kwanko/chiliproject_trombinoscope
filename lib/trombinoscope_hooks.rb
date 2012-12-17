#-- encoding: UTF-8
# Trombinoscope plugin for Chiliproject
# Copyright (C) 2012 Arnauld NYAKU

class TrombinoscopeHooks < Redmine::Hook::ViewListener
    def view_layouts_base_html_head(context = {})
        css = stylesheet_link_tag 'trombinoscope', :plugin => 'chiliproject_trombinoscope'
        js = javascript_include_tag 'trombinoscope', :plugin => 'chiliproject_trombinoscope'
        css + js
    end
end
