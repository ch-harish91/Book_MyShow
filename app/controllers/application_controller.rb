class ApplicationController < ActionController::Base
  # Require login for all pages by default
  before_action :authenticate_user!

  # Allow current_user and logged_in? in views
  helper_method :logged_in?

  # Check if a user is logged in
  def logged_in?
    current_user.present?
  end

  # Redirect after login
  def after_sign_in_path_for(resource)
    movies_path   # Redirect to movies page after login
  end

  # Redirect after logout
  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path   # Redirect to login page after logout
  end

  # Permit extra parameters (e.g., name) for Devise
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :name ])
    devise_parameter_sanitizer.permit(:account_update, keys: [ :name ])
  end
end
