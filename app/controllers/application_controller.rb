class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to user_signed_in? ? root_url : new_user_session_path, alert: exception.message
  end

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :check_group_existence

  def after_sign_in_path_for(user)
    orders_path
  end

  def current_user
    super || Guest.new
  end

  def last_order
    current_user.orders.pending.last
  end
  helper_method :last_order

  def user_signed_in?
    current_user.kind_of? User
  end

  def current_group
    current_user.current_group
  end
  helper_method :current_group

  protected

  def check_group_existence
    return unless should_choose_group?
    redirect_to groups_path, alert: 'You need to join group to start using all available features'
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:account_update) do |u|
      u.permit :password, :password_confirmation, :current_password
    end
  end

  def should_choose_group?
    user_signed_in? &&
      current_user.current_group.blank? &&
      controller_name != 'groups' &&
      !current_user.admin?
  end
end
