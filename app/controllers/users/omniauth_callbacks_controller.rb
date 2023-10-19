# frozen_string_literal: true
class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def cas
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = User.from_cas(request.env["omniauth.auth"])

    if @user.nil?
      redirect_to root_path
      flash[:notice] = "You are not authorized"
    else
      sign_in_and_redirect @user, event: :authentication # this will throw if @user is not activated
      redirect_to "/orcids/#{@user.id}/show"
      if is_navigational_format?
        set_flash_message(:notice, :success, kind: "Princeton Central Authentication Service")
      end
    end
  end
end
