class CreateClientTransactions < ActiveRecord::Migration
  def change
    create_table :client_transactions do |t|
      t.integer :to_client_id
      t.integer :from_client_id
      t.decimal :amount, :precision=>2
      t.integer :transaction_type_id
      t.integer :transaction_status_id

      t.timestamps
    end
  end
end
