#-- encoding: UTF-8
# Trombinoscope plugin for Chiliproject
# Copyright (C) 2012  C2B NETAFFILIATION SA
# Author: Arnauld NYAKU

class TrombinoscopeController < ApplicationController
  include TrombinoscopeHelper
  unloadable

  layout 'base', :only => [:index]
  
  before_filter :find_project
  before_filter :check_if_user_allowed_to_manage_trombinoscope, :only => [:new_picture, :set_picture]

  def index
    @users = @project.nil? ? User.active.all : @project.users.active
    if params[:filter_users] && params[:filter_users] == "2"
       @users.delete_if {|user| !user_picture_exist?(user)}
    end

    if params[:filter_users] && params[:filter_users] == "3"
       @users.delete_if {|user| user_picture_exist?(user)}
    end
    
  end

  def search_trombinoscope_users
    s = "%#{params[:search_user].to_s.strip.downcase}%"
    conditions = ["LOWER(firstname) LIKE :s OR LOWER(lastname) LIKE :s ", {:s => s}]
    @users = @project.nil? ? User.active.find(:all, :conditions => conditions) : @project.users.active.find(:all, :conditions => conditions)
    
    if params[:filter_users] && params[:filter_users] == "2"
       @users.delete_if {|user| !user_picture_exist?(user)}
    end

    if params[:filter_users] && params[:filter_users] == "3"
       @users.delete_if {|user| user_picture_exist?(user)}
    end
    
    render :partial => 'users'
  end

private
# Find project of id params[:id]
 def find_project
   @project = Project.find(params[:project_id]) unless params[:project_id].nil?
  rescue ActiveRecord::RecordNotFound
    render_404
  end

 def check_if_user_allowed_to_manage_trombinoscope
    render_403 if @project.nil? && !User.current.allowed_to?(:manage_trombinoscope, nil, :global => true)
 end
end