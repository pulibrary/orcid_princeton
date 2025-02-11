# frozen_string_literal: true
class Ldap
  class << self
    def find_by_netid(netid)
      connection = default_connection
      filter = Net::LDAP::Filter.eq("uid", netid)
      connection.search(filter:).first
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
