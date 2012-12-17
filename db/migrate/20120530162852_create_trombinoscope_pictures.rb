#-- encoding: UTF-8
# To change this template, choose Tools | Templates
# and open the template in the editor.
class CreateTrombinoscopePictures < ActiveRecord::Migration
  def self.up
    create_table :trombinoscope_pictures do |t|
      t.has_attached_file :picture
    end
  end

  def self.down
    drop_table :trombinoscope_pictures
  end
end

