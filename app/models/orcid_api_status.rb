# frozen_string_literal: true
class OrcidApiStatus < HealthMonitor::Providers::Base
  def check!
    uri = URI("https://api.orcid.org/v3.0/apiStatus")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.read_timeout = 2  # seconds
    response = http.get(uri.request_uri)
    if response.code == "200"
      json = JSON.parse(response.body)
      if json.values.include?(false)
        raise "The ORCID API has an invalid status https://api.orcid.org/v3.0/apiStatus"
      end
    else
      raise "The ORCID API returned HTTP error code: #{response.code}"
    end
  end
end
