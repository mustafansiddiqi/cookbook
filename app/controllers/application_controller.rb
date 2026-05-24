class ApplicationController < ActionController::Base
  include ActionPolicy::Controller

  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  # Redirect to root with an alert when authorization is denied.
  rescue_from ActionPolicy::Unauthorized do |ex|
    redirect_to root_path, alert: "You are not authorized to perform this action."
  end

  def after_sign_in_path_for(resource)
    stored_location_for(resource) || user_path(resource)
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,         keys: [:username, :display_name, :bio])
    devise_parameter_sanitizer.permit(:account_update,  keys: [:username, :display_name, :bio, :avatar])
  end
end
