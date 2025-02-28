# frozen_string_literal: true
Rails.application.config.after_initialize do
  HealthMonitor.configure do |config|
    config.cache

    config.add_custom_provider(OrcidApiStatus).configure do |provider_config|
      # set the orcid API check to not critical
      provider_config.critical = false
    end

    config.file_absence.configure do |file_config|
      file_config.filename = "/opt/orcid_princeton/shared/remove-from-nginx"
    end

    # Make this health check available at /health
    config.path = :health

    config.error_callback = proc do |e|
      Rails.logger.error "Health check failed with: #{e.message}"
      Honeybadger.notify(e) unless e.is_a? HealthMonitor::Providers::FileAbsenceException
    end
  end
end
