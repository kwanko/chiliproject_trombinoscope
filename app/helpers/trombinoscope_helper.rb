#-- encoding: UTF-8
# To change this template, choose Tools | Templates
# and open the template in the editor.

module TrombinoscopeHelper
  # Display picture or a user
  def display_principal_picture_of(user)
    secondary_picture = User.current.allowed_to?(:manage_trombinoscope, nil, :global => true) ? "": content_tag(:span, display_secondary_picture_of(user), :class => "tip")
    tooltip_for_admin =  User.current.allowed_to?(:manage_trombinoscope, nil, :global => true) ?  content_tag(:span, tooltip_for_trombi_user(user), :class => "state_tip") : ""
    trombi_picture = content_tag(:div, (content_tag(:div, image_tag(picture_of(user, "P"), :class => "trombi-user-picture", :plugin => "chiliproject_trombinoscope") + secondary_picture, :class => "#{'tooltip' unless secondary_picture.blank?}") + tooltip_for_admin), :class => "state_tooltip")
    trombi_picture += link_to content_tag(:h6,"#{user.name}", :class => "trombi-user-name"), user_path(user), :title => l(:button_view_profile)
      
    return trombi_picture
  end

  def tooltip_for_trombi_user(user)
    tooltip = ""
    url = {:controller => "trombinoscope_pictures", :action => "new", :id => user.id, :kind => "P"}
    
    tooltip += (user_picture_exist?(user, "P") ? link_to("",  url, :class => 'icon icon-edit ajax-box', :title => l(:button_picture_edit)) : link_to("", url, :class => 'icon icon-add ajax-box', :title => l(:button_picture_add)))
    tooltip += link_to("", {:controller => "trombinoscope_pictures", :action => "delete", :id => user.id, :kind => "P"}, :confirm => l(:text_confirm_delete_picture, :user => user.name),:class => 'icon icon-del', :title => l(:button_picture_delete)) if user_picture_exist?(user, "P")
    tooltip += link_to("", user_path(user), :class => "icon icon-view", :title => l(:button_view_profile))
    tooltip
  end

  def picture_of(user, kind)
    picture = "pictures/default.jpg"
    picture = "pictures/#{user.login}_#{kind}.jpg" if user_picture_exist?(user, kind)
    picture
  end

  def user_picture_exist?(user, kind = "P")
    folder = File.dirname(__FILE__).gsub("app/helpers", "assets/images/pictures/")
    picture_file = folder + "#{user.login}_#{kind}.jpg"

    return File.exist? picture_file
  end

  def display_secondary_picture_of(user)
    return image_tag(picture_of(user, "S"), :class => "trombi-user-secondary-picture", :plugin => "chiliproject_trombinoscope")
  end

end