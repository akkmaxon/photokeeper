class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def provider
    @user = User.from_omniauth(request.env["omniauth.auth"])
    if @user.persisted?
      flash[:notice] = I18n.t 'devise.omniauth_callbacks.success', kind: @user.omni_provider
      sign_in @user
      redirect_to root_path
    else
      failure
    end
  end

  def failure
    flash[:alert] = I18n.t 'devise.omniauth_callbacks.failure',
      kind: @user.omni_provider,
      reason: 'the app is shit!'
    redirect_to new_user_registration_url
  end

  alias_method :twitter, :provider
  alias_method :github, :provider
end
