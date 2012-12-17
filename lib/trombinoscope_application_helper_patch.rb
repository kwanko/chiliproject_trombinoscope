#-- encoding: UTF-8
# Trombinoscope plugin for Chiliproject
# Copyright (C) 2012  Arnauld NYAKU

require 'gravatar'
require_dependency 'application_helper'

module TrombinoscopeApplicationHelperPatch
 include TrombinoscopeHelper
  def self.included(base) # :nodoc:
    base.send(:include, TrombinoscopeApplicationHelperMethods)
    # Same as typing in the class
    base.class_eval do
      unloadable
      alias_method_chain :avatar, :trombinoscope
    end
  end
end

module TrombinoscopeApplicationHelperMethods
# wrap the avatar method in application_helper
  def avatar_with_trombinoscope(user, options = { })
     if Setting.gravatar_enabled?
        if user.is_a?(Group)
          size = options[:size] || 50
          size = "#{size}x#{size}" # image_tag uses WxH
          options[:class] ||= 'gravatar'
          return image_tag("group.png", options.merge(:size => size))
        end
        if user.is_a?(User)
          size = options[:size] || "110x95"
          size = "#{size}x#{size}" unless options[:size].to_s.include?("x")   # image_tag uses WxH
          options[:class] ||= 'gravatar'
          picture = user_picture_exist?(user, "P") ? "pictures/#{user.login}_P.jpg" : "pictures/default.jpg"
          return image_tag("#{picture}", options.merge(:size => size, :plugin => "chiliproject_trombinoscope"))
        end
    else
      ''
    end
  end
end

ApplicationHelper.send(:include, TrombinoscopeApplicationHelperPatch)