class User < ActiveRecord::Base

  has_one :account
  has_one :client
  has_one :user_type, :foreign_key=>'user_type_id'
  has_one :language, :foreign_key=>'lang_id'
  
  before_save :check_pass
  after_save :create_client
  
  def verify(phone, pin)
    self.phone==phone && self.password==pin
  end
  
  def has_at_least(amount)
    self.account.balance >= amount.to_i
  end
  
  private
  
    def has_password?
      !self.password.nil?
    end
    
    def check_pass
      if !has_password?
        pass = generate
 
        while password_used?(pass)==true do
          pass = generate
        end 

        self.password=pass
      end
    end
    
    def password_used?(pwd)
      u = User.find_by_password(pwd)
      if u.nil? #if the user does not exist then the password is not in use
        false
      else
        true
      end
    end
    
    def generate
      #
      # Generate a 6 digit number with a letter following
      #
      #
      pass=""

      for i in 1..6
        pass+=Random.new.rand(0..9).to_s  
      end

      arr = Array.new
      # The letter 'O' (oh) is ommitted because of ambiguities with 0 (zero)
      arr = ['A','B','C','D','E','F','G','H','I','J','K','L','M','N','P','Q','R','S','T','U','V','W','X','Y','Z']

      pass+=arr[Random.new.rand(0..24)]
      return pass
    end
    
    def create_client
      if Client.find_by_user_id(self.id)==nil
          #create the user's client profile with bare basics
        client = Client.new
        client.user_id = self.id
        client.idno=self.password
        client.save!
    
        #create the account associated with the user
        account = Account.new
        account.user_id=self.id
        account.client_id=client.id      
        account.balance=0
        account.save!
      else
        self.client.save
        self.account.save
      end
    end
end
