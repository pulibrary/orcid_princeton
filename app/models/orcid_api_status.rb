# frozen_string_literal: true
class OrcidApiStatus < HealthMonitor::Providers::Base
  def check!
    response = orcid_api_status
    if response.code == "200"
      json = JSON.parse(response.body)
      if json.values.include?(false)
        raise "The ORCID API has an invalid status https://api.orcid.org/v3.0/apiStatus"
      end
    else
      raise "The ORCID API returned HTTP error code: #{response.code}"
    end
  end

  private

    def orcid_api_status
      uri = URI("https://api.orcid.org/v3.0/apiStatus")
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      http.read_timeout = 2 # seconds
      response = http.get(uri.request_uri)

      # allow one retry to let the us or the api recover from small glitches
      unless response.is_a? Net::HTTPSuccess
        sleep(0.5)
        response = http.get(uri.request_uri)
      end
      response
    end
end
