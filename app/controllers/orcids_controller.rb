# frozen_string_literal: true
class OrcidsController < ApplicationController
  def show
    @user = User.find(params["id"])
  end

  # Authenticate to ORCID.org
  def create
    omniauth = request.env["omniauth.auth"]
    current_user.orcid = omniauth.uid
    current_user.save
    Token.create_from_omniauth(omniauth.credentials, current_user)
    redirect_to user_path(current_user)
  end
end
