#-- encoding: UTF-8
# Trombinoscope plugin for Chiliproject
# Copyright (C) 2012 Arnauld NYAKU

class TrombinoscopeMyAccountHooks < Redmine::Hook::ViewListener
  render_on :view_my_account, :partial => 'my/my_account_trombinoscope_form', :multipart => true
end

