class Public::SessionsController < Devise::SessionsController
  before_action :configure_permitted_parameters
  before_action :reject_inactive_user, only: [:create]

  def after_sign_in_path_for(resource)
    user_path(current_user) # ログイン後に表示するページを指定
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password])
  end

  def reject_inactive_user
    @user = User.find_by(email: params[:user][:email])

    if @user
      if @user.valid_password?(params[:user][:password]) && !@user.is_deleted
        sign_in(@user)
        flash[:notice] = "ログインしました"
      else
        flash[:notice] = "正しい情報を入力してください"
      end
    else
      flash[:notice] = "会員情報が見つからないため、再度会員登録をお願いします"
    end
  end
end
