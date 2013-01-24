class AddLangAndTypeToUser < ActiveRecord::Migration
  def change
    add_column :users, :lang_id, :integer
    add_column :users, :user_type_id, :integer
  end
end
