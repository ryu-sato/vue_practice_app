class Users::OmniauthController < Devise::OmniauthCallbacksController
  def facebook
    @user = User.find_or_create_for_oauth(request.env['omniauth.auth'])

    if @user.persisted?
      set_flash_message(:notice, :success, kind: "Facebook") if is_navigational_format?
      sign_in_and_redirect @user, event: :authentication
    else
      set_flash_message(:alert, :failure, kind: "Facebook", reason: 'User not found and cannot register')
      session["devise.facebook_data"] = request.env['omniauth.auth']
      redirect_to new_user_session_path
    end
  end

  def failure
    redirect_to new_user_session_path
  end
end
