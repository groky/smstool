class UserType < ActiveRecord::Base
  belongs_to :user
  
  def self.ADMIN
    "ADMIN"
  end
  
  def self.SUBSCRIBER
    "SUBSCRIBER"
  end
  
end
