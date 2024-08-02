# frozen_string_literal: true
class UsersController < ApplicationController
  before_action :set_user, only: [:show]

  # GET /users/1 or /users/1.json
  def show
    # Is this the logged in user's own page?
    @my_page = current_user.id.to_s == @user.id.to_s
    # Unless this page belongs to the logged in user, return 403 Forbidden.
    render "errors/forbidden", status: :forbidden, formats: [:html] unless @my_page
  end

  # POST /users/1/validate-tokens
  def validate_tokens
    user = User.find(params[:id])
    user.revoke_invalid_tokens
    redirect_to user_path(user)
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    # Do not allow any fishing for what database ids exist. Return 403 Forbidden.
    rescue ActiveRecord::RecordNotFound
      render "errors/forbidden", status: :forbidden, formats: [:html]
    end
end
