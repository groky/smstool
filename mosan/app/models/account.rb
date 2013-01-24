class Account < ActiveRecord::Base
  belongs_to :user, :foreign_key=>:user_id
  belongs_to :client, :foreign_key=>:client_id
end
