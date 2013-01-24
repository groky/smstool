class ClientTransactions < ActiveRecord::Base
  def self.record(client_from, client_to, amount, type, status)
    txn = ClientTransactions.new
    txn.from_client_id = client_from.id
    txn.to_client_id = client_to.id
    txn.amount = amount
    txn.transaction_type_id = type
    txn.transaction_status_id = status
    
    txn.save
    
    # add the client id and user_id
    # add the content information : amounts, from, to, type, etc    
  end
end
