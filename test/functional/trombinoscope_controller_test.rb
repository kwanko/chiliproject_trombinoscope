# To change this template, choose Tools | Templates
# Trombinoscope plugin for Chiliproject
# Copyright (C) 2012  C2B NETAFFILIATION SA
# Author: Arnauld NYAKU

require File.dirname(__FILE__).gsub("functional", "test_helper");


class TrombinoscopeControllerTest < ActionController::TestCase

  fixtures :all
  
  context 'TrombinoscopePlugin' do

    def test_index
      get :index
      assert_response :success
      assert_template :index
      assert_not_nil assigns(:users)
    end

    def test_index_with_picture
      get :index, :filter_users => 2
      assert_response :success
      assert_template :index
      assert_not_nil assigns(:users)
    end

    def test_index_without_picture
      get :index, :filter_users => 3
      assert_response :success
      assert_template :index
      assert_not_nil assigns(:users)
    end
   
    def test_index_with_project
      get :index, :project_id => 1
      assert_response :success
      assert_template :index
      assert_not_nil assigns(:users)
    end

    def test_index_with_project_and_picture
      get :index, :project_id => 1, :filter_users => 2
      assert_response :success
      assert_template :index
      assert_not_nil assigns(:users)
    end

    def test_index_with_project_without_picture
      get :index, :project_id => 1, :filter_users => 3
      assert_response :success
      assert_template :index
      assert_not_nil assigns(:users)
    end

    def test_search_trombinoscope_users
      get :search_trombinoscope_users, :search_user => 'allo'
      assert_response :success
      assert_template :users
      assert_not_nil assigns(:users)
    end
  end
end

