#-- encoding: UTF-8
# Trombinoscope plugin for Chiliproject
# Copyright (C) 2012 Arnauld NYAKU

module TrombinoscopeMyControllerPatch
  def self.included(base) # :nodoc:
    base.send(:include, InstanceMethods)

    base.class_eval do
      unloadable
      alias_method_chain :account, :trombinoscope
    end
  end
  module InstanceMethods
    def account_with_trombinoscope
      account_without_trombinoscope
      if request.post? && @user.save
        if params[:pref][:picture]
          @trombi_picture = TrombinoscopePicture.create(:picture => params[:pref][:picture])

          folder = File.dirname(__FILE__).gsub("lib", "assets/images/pictures/")
          FileUtils.remove_file("#{folder}#{@user.login}_S.jpg", true)  if File.exist?("#{folder}#{@user.login}_S.jpg")
          File.rename("#{folder}#{@trombi_picture.picture_file_name}", "#{folder}#{@user.login}_S.jpg")
          FileUtils.copy_entry("#{folder}#{@user.login}_S.jpg", "#{Rails.root}/public/plugin_assets/chiliproject_trombinoscope/images/pictures/#{@user.login}_S.jpg", :remove_destination => true)
          @trombi_picture.delete
        end
      end
    end
  end
end

require 'dispatcher'

Dispatcher.to_prepare do
  MyController.send(:include, TrombinoscopeMyControllerPatch)
end
