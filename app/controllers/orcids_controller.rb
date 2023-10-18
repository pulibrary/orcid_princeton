# frozen_string_literal: true
class OrcidsController < ApplicationController
  # Allow the user to enter their orcid and
  # authenticate to the orcid organization to create a token
  def show
    @user = User.find(params["id"])
  end

  def create
    omniauth = request.env["omniauth.auth"]
    session[:omniauth] = omniauth
    session[:params]   = params
  end
end
