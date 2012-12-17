#-- encoding: UTF-8
# To change this template, choose Tools | Templates
# and open the template in the editor.

class TrombinoscopePicture < ActiveRecord::Base
  has_attached_file :picture, :styles => {:original => "120x100",:thumbnail => "120x100#"}, :processors => [:face_crop], :path => File.dirname(__FILE__).gsub('app/models', 'assets/images/pictures/:basename.:extension')
end
