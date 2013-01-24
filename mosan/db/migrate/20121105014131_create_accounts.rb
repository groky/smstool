class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.decimal :balance, :precision=>2
      t.integer :client_id
      t.integer :user_id

      t.timestamps
    end
  end
end
