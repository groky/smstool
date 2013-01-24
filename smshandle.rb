
class SMSHandle
  
  attr_accessor :longpath, :errors
  
  #check username(phone number) and password are correct
  def validate_user(uname, password)
    #validation
  end
  
  def message_is_correct(msg, bits)
    #REGEX VALIDATION
    iscorrect=true
    if !TRANSFER_REGX=~msg
      #check if the members of the string are correct
      #form 'tf 30 77777777 098765G'
      @errors = Array.new
      @errors = Utils.add_error(@errors, 'SMS laloos.')
      if !TX_TYPE_REGX=~bits['txtype']
        @errors = Utils.add_error(@errors, "hahuu ho 'tf'.")
      end
      if !TX_AMOUNT_REGX=~bits['amount']
        @errors = Utils.add_error(@errors, "Osan hira tenke uza numeru. Labele sae liu $999")
      end
      if !TX_TO_NUM_REGX=~bits['to']
        @errors = Utils.add_error(@errors, "Lahalua ema atu simu numeru tenke hetan numeru 8 tomak")
      end
      if !TX_AUTH_REGX=~bits['password']
        @errors = Utils.add_errors(@errors, "Ita boot presiza pin. Ezemplu: 000000x")
      end
      @errors = Utils.add_errors(@errors, "Koko fali. Sekarik Ita boot atu koalia, kontaktu MOSAN. Obrigado.")
      iscorrect=false
    end
    
    return iscorrect      
  end
  
  def message_file(f)
    sms = {}
    if f!='.' && f!='..'
      @longpath = "#{PATH}/#{f}"
  
      if File.exists?(@longpath)
        puts "received message................ #{f}"
        #check that the file can be read in
        begin
          File.open(@longpath, 'r').each_line do |line|
            line = line.strip.split ':'
            if line.first.to_s==line.last.to_s
              sms['MSG']=line.last.to_s.upcase
            else
              sms[line.first.to_s.upcase] = line.last.to_s.upcase
            end
          end
        rescue
          puts "#{@longpath} could not be read"
        end
      end
    end
    #puts "This is sms: #{sms}"
    return sms
  end
  
  def longpath
    @longpath
  end
  
  def errors
    @errors
  end
  
  def file_transfer(f, error=false)
    begin
      path = (error ? ERROR_PATH : PROCESSED_PATH)
      #copy the file
      FileUtils.cp(longpath, "#{path}#{f}")
      #then delete it - or wrtie it to a database
      FileUtils.rm(longpath)
    rescue
      puts "The file copy failed.... for: #{f}"
    end
  end
  
  #build the sms strings and send them
  #@TODO find out how to keep the system alive after the exec statement
  def send_response_sms(from, contents, data)
    txtreturn = "'You have successfully sent $#{contents['amount']} to #{contents['to']}. 
            Your new balance is: $#{data['SBALANCE']}. MOSAN'"
    sender = "sendsms #{from} #{txtreturn}"
  
    txtto = "'You received $#{contents['amount']} from #{from}. Your new balance is: $#{data['CBALANCE']}. MOSAN'"
    receiver="sendsms #{contents['to']} #{txtto}"
    begin
      `#{sender}`
      `#{receiver}`
      puts "The sms's have been sent..."
      
    rescue
      puts "The response could not be sent to the sender #{from} and the recipient #{contents['to']}. 
            The transaction was successful."
    end
  end
  
  def http(from, msg, contents)
    succeeded = false
    
    params=URI::encode("#{from} #{msg}")
    resource = Net::HTTP.new(HOST,PORT)
    headers,data = resource.get("#{RESOURCE}#{params}")

    # For this demo, report on data retrieved
    puts "The Response data: #{data}"
    puts "Status code: #{headers.code}"
    data = JSON.parse(data)
    
    if data.nil?
      puts 'not sure what happened'
      @errors = Utils.add_errors @errors, "HTTP::There was no response data"
    else
      puts "TX STATUS #{data['TXSTATUS']}"
      if data['TXSTATUS']==1 && headers.code==200.to_s
        puts 'the transaction was completed successfully'
        
        send_response_sms from, contents, data
        succeeded=true
      else
        #handle the problem here
        #maybe shelve the sms for later. or put it away altogether
        puts 'the transaction crashed and died in the arse!'
        puts 'did not process. sms not copied'
        @errors = Utils.add_errors @errors, "SMSHandle.http\n TX_DATA:#{data}\nSTATUS_CODE:#{headers.code}"
      end
    end
    return succeeded
  end
end