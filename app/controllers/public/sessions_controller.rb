# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  before_action :configure_permitted_parameters
  before_action :reject_customer, only: [:create]
  before_action :authenticate_user!, only: [:destroy]


  def after_sign_in_path_for(resource)
    root_path
  end
  
  def destroy
    super do |resource|
      sign_out(resource)
      redirect_to root_path
      return
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password])
  end

  
  def after_sign_in_path_for(resource)
    mypage_path
  end

  def after_sign_out_path_for(resource)
    root_path
  end
  
end
