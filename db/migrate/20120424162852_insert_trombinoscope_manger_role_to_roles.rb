#-- encoding: UTF-8
# To change this template, choose Tools | Templates
# and open the template in the editor.

class InsertTrombinoscopeMangerRoleToRoles < ActiveRecord::Migration
  class Role < ActiveRecord::Base; end
  def self.up
    r = Role.new(:name => "TrombinoscopeManager", :assignable => 0, :position => Role.last.position + 1, :builtin => 0, :permissions => [:manage_trombinoscope])
    r.save!
  end

  def self.down
    Role.delete_all(:name => "TrombinoscopeManager")
  end
end
