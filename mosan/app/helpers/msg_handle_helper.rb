module MsgHandleHelper
  
  def user_exists(user)
    is_nil user 
  end
  
  def add_message_to(container, key, message)
    container[key] = message
    #puts container
    return container
  end
end
