#-- encoding: UTF-8
# To change this template, choose Tools | Templates
# and open the template in the editor.

class TrombinoscopePicturesController < ApplicationController

  def new
   @user = User.find(params[:id]) if params[:id]
   @kind = params[:kind] if params[:kind]
   @trombinoscope_picture = TrombinoscopePicture.new
   render :layout => false
  end
  
  def create
    @trombinoscope_picture = TrombinoscopePicture.create(params[:trombinoscope_picture])
    if params[:id] && params[:kind]
      @user = User.find(params[:id])
      create_user_picture(@trombinoscope_picture, @user, params[:kind])
    end
    redirect_to :controller => "trombinoscope", :action => "index"
  end

  def delete
    if params[:id] && params[:kind]
      @user = User.find(params[:id])
      kind = params[:kind]
      from = params[:from] if params[:from]
      FileUtils.remove_file("#{File.dirname(__FILE__).gsub('app/controllers', 'assets/images/pictures/')}#{@user.login}_#{kind}.jpg", true)
      FileUtils.remove_file("#{Rails.root}/public/plugin_assets/chiliproject_trombinoscope/images/pictures/#{@user.login}_#{kind}.jpg", true)
    end
    redirect_to :controller => "trombinoscope", :action => "index" if kind == "P"
    redirect_to :controller => "my", :action => "account" if kind == "S" && from == "my"
    redirect_to user_path(@user) if kind == "S" && from == "user"    
  end

private
  def create_user_picture(trombinoscope_picture, user, kind)
    folder = File.dirname(__FILE__).gsub("app/controllers", "assets/images/pictures/")
    File.rename("#{folder}#{trombinoscope_picture.picture_file_name}", "#{folder}#{user.login}_#{kind}.jpg")
    FileUtils.copy("#{folder}#{user.login}_#{kind}.jpg", "#{Rails.root}/public/plugin_assets/chiliproject_trombinoscope/images/pictures/")
    trombinoscope_picture.delete
  end
end
