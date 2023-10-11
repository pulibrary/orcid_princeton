class CreateTokens < ActiveRecord::Migration[7.1]
  def change
    create_table :tokens do |t|
      t.string :token_type
      t.string :token
      t.datetime :expiration
      t.string :scope
      t.integer :user_id

      t.timestamps
    end
  end
end
