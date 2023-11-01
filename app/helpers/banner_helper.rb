# frozen_string_literal: true

require "yaml"

module BannerHelper
  # rubocop:disable Rails/ContentTag
  def banner_content
    @yaml_data = Rails.configuration.banner
    return false if @yaml_data.nil?
    @banner_title = "<h1>#{@yaml_data['title']}</h1>"
    @banner_body = "<p>#{@yaml_data['body']}</p>"
  end
  # rubocop:enable Rails/ContentTag
end
