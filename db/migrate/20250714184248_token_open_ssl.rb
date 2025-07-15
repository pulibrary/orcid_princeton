class TokenOpenSsl < ActiveRecord::Migration[7.1]
  def change
    add_column :tokens, :openssl_token, :string
  end
end
