# frozen_string_literal: true
namespace :users do
  desc "Adds a fake token to a user to emulate linking to ORCiD"
  task :fake_orcid_link, [:netid] => [:environment] do |_, args|
    netid = args[:netid]
    user = User.where(uid: netid).first
    token_value = SecureRandom.hex
    expiration = DateTime.now + 30
    user_token = Token.new(user_id: user.id, token_type: "bearer", token: token_value, expiration:)
    user_token.save!
    puts "Added token #{token_value} to user #{netid}. Expiration: #{expiration}"
  end

  desc "Checks if an ORCiD token is valid for a given ORCiD"
  task :check_orcid_token, [:token, :orcid] => [:environment] do |_, args|
    token = args[:token]
    orcid = args[:orcid]
    valid = Token.valid_in_orcid?(token, orcid)
    puts "Token #{token} is valid for ORCiD #{orcid}: #{valid}"
  end
end
