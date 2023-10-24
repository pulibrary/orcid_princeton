# frozen_string_literal: true
class OrcidsController < ApplicationController
  def show
    @user = User.find(params["id"])
  end

  # Authenticate to ORCID.org
  def create
    omniauth = request.env["omniauth.auth"]
    session[:omniauth] = omniauth
    session[:params]   = params
    Rails.logger.info("omniauth: #{omniauth.inspect}")
    Rails.logger.info("params: #{params.inspect}")
    redirect_to user_show_path(current_user)
  end
end
