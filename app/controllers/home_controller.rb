# frozen_string_literal: true
class HomeController < ApplicationController
  skip_before_action :authenticate_user!
  def index; end
  
  def orcid_report
    render "errors/forbidden", status: :forbidden, formats: [:html]
  end
end
