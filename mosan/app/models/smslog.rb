class Smslog < ActiveRecord::Base
  
  def self.log(sender, receiver, msg)
    sms = Smslog.new
    sms.client_id=Client.find_by_user_id(sender.id).id
    sms.from_number=sender.phone
    sms.to_number=receiver.phone
    sms.sms = msg
    sms.save
  end
end
