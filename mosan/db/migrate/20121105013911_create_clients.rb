class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string :name
      t.string :surname
      t.string :idno
      t.integer :user_id

      t.timestamps
    end
  end
end
