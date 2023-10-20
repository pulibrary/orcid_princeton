# frozen_string_literal: true
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  def new_session_path(_scope)
    new_user_session_path
  end

  def after_sign_in_path_for(_resource)
    "/users/#{@user.id}"
  end
end
