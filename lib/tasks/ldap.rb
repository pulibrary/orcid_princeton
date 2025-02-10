# frozen_string_literal: true
namespace ldap do
  task :fetch, [:netid] => [:environment] do |_, args|
    # For existing users, run a one time task to query LDAP and load University IDs where they are missing from the user.
    netid = args[:netid]
    ldap_user = Ldap.find_by_netid(netid)
    if ldap_user
      user = User.find_by(uid: netid)
      if user
        user.update_attribute(:university_id, ldap_user[:princetonuniversityid].first)
        puts "Updated user #{netid} with university ID #{ldap_user[:princetonuniversityid].first}"
      else
        puts "User #{netid} not found in the database"
      end
    else
      puts "User #{netid} not found in LDAP"
    end
  end
end
# frozen_string_literal: true
module Ldap
  class << self
    def find_by_netid(netid)
      connection = default_connection
      filter = Net::LDAP::Filter.eq("uid", netid)
      connection.search(filter: filter).first
    end

    private

    def default_connection
      @default_connection ||= Net::LDAP.new host: "ldap.princeton.edu", base: "o=Princeton University,c=US", port: 636,
                                            encryption: {
                                              method: :simple_tls,
                                              tls_options: OpenSSL::SSL::SSLContext::DEFAULT_PARAMS
                                            }
    end
  end
end