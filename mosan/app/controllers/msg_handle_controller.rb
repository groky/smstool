class MsgHandleController < ApplicationController
  include ApplicationHelper
  include MsgHandleHelper
  
  def handle
    msg = params[:msg]
    vars = msg.split  
    
    @rdata = {} #this is the response data which is sent to the client
    @errors ={} #this is for the errors which will be packed snuggly inside the response data
    
    content = {"from"=>vars[0], "txtype"=>vars[1], "amount"=>vars[2], "to"=>vars[3], "password"=>vars[4]}
    
    puts "#{msg} \n"
    puts "#{content.to_s}\n moving on... \n #{content['from']}"

    sender = User.find_by_phone(content['from'])
    receiver = User.find_by_phone(content['to'])
    
    ok=false
    #the sender does not exist as a client
    #begin
      
    if !User.exists?(sender)
      @message = "Account #{content['from']} la iha! \nFoin loke akonta foun, depois Ita Boot bela uza sisteme. 
                  Sekarik Ita Boot presiza ajuda, kontaktu MOSAN ba informasaun. Obrigado"
      puts @message
      @errors = add_message_to @errors, 'NOT_EXIST', @message
    else #the sender has an account
      puts "verify #{content['from']}, #{content['password']}"
      if sender.verify content['from'], content['password']
        puts "verified #{content['from']}"
        if sender.has_at_least(content['amount']) 
          puts "the client has the money!"
          if !User.exists?(receiver)
            puts "New receiver..."
            #create receiver account/this also creates the client
            receiver = User.new
            receiver.phone = content['to']
            receiver.lang_id = 3 #TT Tetun
            receiver.save
          end
   
          receiver.account.balance = receiver.account.balance + content['amount'].to_i
          sender.account.balance = sender.account.balance - content['amount'].to_i
        
          receiver.save
          sender.save
          ok=true
          #perform transaction log
        
          #send the confirmation sms?
        
        else #the sender does not have the amount they are attempting to transfer
            @message = "Account #{content['from']} osan too #{content['amount']} la iha! \nFoin hatama osan too, depois Ita Boot bela uza sisteme. 
                        Sekarik Ita Boot presiza ajuda, kontaktu MOSAN ba informasaun.Obrigado"
            ok = false
            
        end #end user has the cash
      else
        @message = "Account #{content['from']} PIN laloos! \nFavor koko fali. 
                    Sekarik Ita Boot presiza ajuda, kontaktu MOSAN ba informasaun. Obrigado"
        @errors = add_message_to @errors, 'INCORRECT_PIN', @message
        ok = false          
      end #end User Exists

      if ok
        tstatus = TransactionStatus.find_by_code("CONFIRMED").id
        @message = 1
        #give the balances
        @rdata = add_message_to @rdata, 'SBALANCE', sender.account.balance
        @rdata = add_message_to @rdata, 'CBALANCE', receiver.account.balance
      else
        tstatus = TransactionStatus.find_by_code("FAILURE").id
        @message = 0
      end
      
      @rdata = add_message_to @rdata, 'TXSTATUS', @message

      @rdata = add_message_to @rdata, 'ERRORS', @errors if @errors.length>0
  
      puts "the sender: #{sender}"
      puts "the receiver: #{receiver}"

      ClientTransactions.record(sender.client,
                                receiver.client,
                                content['amount'].to_i,
                                TransactionType.find_by_name("#{content['txtype'].upcase}").id,
                                tstatus)
      #perform message log
      Smslog.log(sender, receiver, msg)
    end
    
    puts @rdata
    respond_to do |format|
      format.js { render :text=>@rdata.to_json }
    end
     
    
  end

end
