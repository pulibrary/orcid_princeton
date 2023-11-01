# frozen_string_literal: true
module UsersHelper
  def full_orcid_display(orcid_identifier)
    return unless orcid_identifier
    full_orcid_display = ""
    full_orcid_display += "<div class='full_orcid_display'>"
    full_orcid_display += image_tag vite_asset_path("images/ORCIDiD_icon64x64.png"), alt: "ORCID icon"
    full_orcid_display += " "
    orcid_url = "https://orcid.org/#{orcid_identifier}"
    full_orcid_display += link_to orcid_url, orcid_url
    full_orcid_display += "</div>"
    full_orcid_display.html_safe
  end
end
