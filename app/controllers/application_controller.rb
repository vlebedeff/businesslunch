class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to user_signed_in? ? root_url : new_user_session_path, alert: exception.message
  end

  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(user)
    orders_path
  end

  def current_user
    super || Guest.new
  end

  def user_signed_in?
    current_user.kind_of? User
  end

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:account_update) do |u|
      u.permit :password, :password_confirmation, :current_password
    end
  end
end
