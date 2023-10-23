# frozen_string_literal: true
class OrcidApiStatus < HealthMonitor::Providers::Base
  def check!
    uri = URI("https://api.orcid.org/v3.0/apiStatus")
    response = Net::HTTP.get(uri)
    json = JSON.parse(response)
    if json.values.include?(false)
      raise "The ORCID API has an invalid status https://api.orcid.org/v3.0/apiStatus"
    end
  end
end
