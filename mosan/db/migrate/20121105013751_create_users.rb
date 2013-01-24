class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :login
      t.string :password
      t.string :phone
      t.string :email

      t.timestamps
    end
  end
end
