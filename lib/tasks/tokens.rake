# frozen_string_literal: true
namespace :tokens do
  desc "Saves the token with open ssl"
  task openssl: :environment do
    encryption_helper = EncryptionHelper.new
    Token.all.each do |token|
      token.openssl_token = encryption_helper.encrypt(token.token)
      token.save
    end
  end
end
