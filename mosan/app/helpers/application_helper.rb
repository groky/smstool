module ApplicationHelper
  #get the correct title for the page
  def title
    base_title = "smstransfers.tl"
    @title.nil? ? base_title : "#{base_title} | #{@title}"
  end
  
  def admin_exists?
    @admin = User.find_by_user_type_id(UserType.find_by_name(UserType.ADMIN))
    true if !@admin.nil? else false
  end
end
