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
  end
end
