
require './boot'

puts "checking... #{PATH} ................."
loop do
    Dir.foreach(PATH) do |f|
  
      #create a handler
      handle = SMSHandle.new
      sms = handle.message_file(f)
    
      if !(sms.length < 1)
      
        from = Utils.makefromnum(sms["FROM"].strip)    
        contents = Utils.msg2array(sms["MSG"])

        puts from
        puts sms['MSG']
        #test the sms
    
        if !handle.message_is_correct(sms['MSG'], contents)
          puts handle.errors
          handle.file_transfer f, true
          break
        else
          if handle.http(from, sms['MSG'], contents)
            handle.file_transfer f, false
          else
            puts handle.errors
          end
        end
      
      else
        #puts "The message is empty"
        #send a response sms with the error to the sender
      end
    
    end #end Dir
end   #end loop
