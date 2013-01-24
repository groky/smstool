module UserHelper
  
  def register_path
    link_to "Register", :controller=>:user, :action=>:new
  end
  
  def edit_user_path(user)
    link_to "Edit", :controller=>:user, :action=>:update, :id=>user.id
  end
  
  def delete_user_path(user)
    link_to "Delete", :controller=>:user, :action=>:detroy, :id=>user.id
  end
  
end
