class ApplicationController < ActionController::Base
  include Services
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def after_sign_in_path_for(_)
    UserMailer.new.sent_mail(user: current_user)
    home_path
  end

  def after_sign_out_path_for(_)
    new_user_session_path
  end

  def after_update_path_for(_)
    home_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,
                                      keys: [:username,
                                             :avatar,
                                             :avatar_cache,
                                             :email,
                                             :password,
                                             :password_confirmation,
                                             :remember_me])
    devise_parameter_sanitizer.permit(:sign_in,
                                      keys: [:login,
                                             :avatar,
                                             :avatar_cache,
                                             :email,
                                             :password,
                                             :password_confirmation,
                                             :remember_me])
    devise_parameter_sanitizer.permit(:account_update,
                                      keys: [:email,
                                             :avatar,
                                             :avatar_cache,
                                             :password,
                                             :password_confirmation,
                                             :current_password])
  end
end
