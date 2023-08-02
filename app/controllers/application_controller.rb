class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :check_user_approval, if: :devise_controller?, unless: :devise_controller?

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:approved])
    devise_parameter_sanitizer.permit(:account_update, keys: [:approved])
  end

  def check_user_approval
    if user_signed_in? && !current_user.approved?
      flash[:notice] = "Please wait until admin approves your account."
      redirect_to root_path
    end
  end
end

