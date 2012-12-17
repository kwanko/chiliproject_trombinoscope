#-- encoding: UTF-8
# Trombinoscope plugin for Chiliproject
# Copyright (C) 2012  C2B NETAFFILIATION SA
# Author: Arnauld NYAKU

require File.expand_path('../../test_helper', __FILE__)

require 'trombinoscope_picture'

class TrombinoscopePictureTest < ActiveSupport::TestCase
  fixtures :users, :trombinoscope_pictures

  def test_truth
    assert true
  end
end
