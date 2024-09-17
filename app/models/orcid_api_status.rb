# frozen_string_literal: true
class OrcidApiStatus < HealthMonitor::Providers::Base
  def check!
    Net::HTTP.start("https://api.orcid.org") do |http|
      http.read_timeout = 2  # seconds
      response = http.get("/v3.0/apiStatus")
      json = JSON.parse(response)
      if json.values.include?(false)
        raise "The ORCID API has an invalid status https://api.orcid.org/v3.0/apiStatus"
      end
    end
  end
end
