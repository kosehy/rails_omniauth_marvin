#  app/controllers/users/omniauth_callbacks_controller.rb

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def marvin
        # @user = User.from_omniauth(request.env["omniauth.auth"])
        @user = User.find_for_oauth(request.env["omniauth.auth"], current_user)

        if @user.persisted?
            sign_in_and_redirect @user, :event => :authentication
            set_flash_message(:notice, :success, :kind => "42") if is_navigational_format?
        else
            session["devise.marvin_data"] = request.env["omniauth.auth"]
            redirect_to new_user_registration_url
        end
    end
  end