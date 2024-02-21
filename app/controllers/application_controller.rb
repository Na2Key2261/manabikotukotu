class ApplicationController < ActionController::Base
  #ログイン機能完成するまではコメント
  #before_action :authenticate_admin!
  before_action :configure_permitted_parameters, if: :devise_controller?
  helper_method :guest_signed_in?

  def guest_signed_in?
    current_user && current_user.guest?
  end
  

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end
