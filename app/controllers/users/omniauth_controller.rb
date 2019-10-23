class Users::OmniauthController < Devise::OmniauthCallbacksController
  def facebook
    find_or_create_user_and_login("Facebook")
  end

  def google_oauth2
    find_or_create_user_and_login("Google")
  end

  def failure
    redirect_to new_user_session_path
  end

  private

  def find_or_create_user_and_login(oauth_kind)
    @user = User.find_or_create_for_oauth(request.env['omniauth.auth'])

    if @user.persisted?
      set_flash_message(:notice, :success, kind: oauth_kind) if is_navigational_format?
      sign_in_and_redirect @user, event: :authentication
    else
      set_flash_message(:alert, :failure, kind: oauth_kind, reason: 'User not found and cannot register')
      session["devise.facebook_data"] = request.env['omniauth.auth']
      redirect_to new_user_session_path
    end
  end
end
