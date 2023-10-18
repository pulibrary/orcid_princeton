# frozen_string_literal: true
require "sul_orcid_client"

namespace :orcid_api do
  task :fetch, [:orcid_id] => [:environment] do |_, args|
    if ENV["ORCID_CLIENT_ID"].nil?
      puts "ORCID_CLIENT_ID not found on the ENV variables"
      exit
    end

    if ENV["ORCID_CLIENT_SECRET"].nil?
      puts "ORCID_CLIENT_SECRET not found on the ENV variables"
      exit
    end

    # Use the ORCID ID provided or default to the one used in the
    # the sul_orcid_client examples which has a fair amount of data.
    orcid_id = args[:orcid_id] || "0000-0002-7262-6251"

    # Hardcoded for now to the ORCID sandbox, but we want to use the
    # real ORCID URL once we have access to production.
    client = SulOrcidClient.configure(
      client_id: ENV["ORCID_CLIENT_ID"],
      client_secret: ENV["c"],
      base_url: "https://api.sandbox.orcid.org",
      base_public_url: "https://pub.sandbox.orcid.org",
      base_auth_url: "https://sandbox.orcid.org"
    )

    puts "Fetching information for ORCID: #{orcid_id}..."
    puts client.fetch_name(orcidid: "https://sandbox.orcid.org/#{orcid_id}")
    puts client.fetch_works(orcidid: "https://sandbox.orcid.org/#{orcid_id}")
  end
end
