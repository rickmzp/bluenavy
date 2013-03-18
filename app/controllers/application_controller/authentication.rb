module ApplicationController::Authentication
  extend ActiveSupport::Concern

  included do
    before_filter :ensure_sign_in
    helper_method :current_user
  end

  def ensure_sign_in
    redirect_to new_session_url if not signed_in?
  end

  def signed_in?
    current_user.present?
  end

  def sign_in_as(name)
    self.current_user = User.named(name)
  end

  def sign_out
    self.current_user = nil
  end

  def current_user
    return if not session.has_key?(:user_name)
    @current_user ||= User.named(session[:user_name])
  end

  def current_user=(user)
    return session.delete(:user_name) if user.blank?
    session[:user_name] = user.name
  end
end
