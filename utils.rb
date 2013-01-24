class Utils
  
  def self.msg2array(msg)
    msgarr = msg.split
    contents = {
                "txtype"=>msgarr[0], 
                "amount"=>msgarr[1], 
                "to"=>msgarr[2], 
                "password"=>msgarr[3]
                }
    return contents
  end
  
  def self.makefromnum(from) #remove the 670
    from = from.slice(3..from.length)
    return from
  end
  
  def self.add_error(container, message)
    container<<message
    return container
  end
  
end