# frozen_string_literal: true
class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def cas
    logger.error("In cas callback")
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = User.from_cas(request.env["omniauth.auth"])
    logger.error("user #{@user}")

    if @user.nil?
      redirect_to root_path
      flash[:notice] = "You are not authorized"
    else
      logger.error(" we are signing in")
      sign_in_and_redirect @user, event: :authentication # this will throw if @user is not activated
      logger.error(" done signing in")
      if is_navigational_format?
        set_flash_message(:notice, :success, kind: "Princeton Central Authentication Service")
      end
    end
  end
end
