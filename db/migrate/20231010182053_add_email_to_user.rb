class AddEmailToUser < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :email, :string
    remove_index :users, :uid
    add_index :users, :uid, unique: true
  end
end
