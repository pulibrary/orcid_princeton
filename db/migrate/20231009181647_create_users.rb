class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :uid
      t.string :provider
      t.string :orcid
      t.string :given_name
      t.string :family_name
      t.string :display_name

      t.timestamps
    end
    add_index :users, :uid
    add_index :users, :provider
  end
end
