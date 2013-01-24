class CreateTransactionStatuses < ActiveRecord::Migration
  def change
    create_table :transaction_statuses do |t|
      t.string :code
      t.string :description

      t.timestamps
    end
  end
end
