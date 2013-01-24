class CreateSmslogs < ActiveRecord::Migration
  def change
    create_table :smslogs do |t|
      t.integer :client_id
      t.decimal :from_number
      t.decimal :to_number
      t.text :sms

      t.timestamps
    end
  end
end
