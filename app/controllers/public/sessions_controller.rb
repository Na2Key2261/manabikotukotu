class Public::SessionsController < Devise::SessionsController
  before_action :configure_permitted_parameters
  before_action :reject_inactive_user, only: [:create]

  def after_sign_in_path_for(resource)
    mypage_path
  end

  def after_sign_out_path_for(resource)
    root_path
  end

  def guest_sign_in
    user = User.guest
    sign_in user
    redirect_to public_posts_path, notice: 'ゲストユーザーとしてログインしました。'
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password])
  end

  def reject_inactive_user
    @user = User.find_by(email: params[:user][:email])

    if @user
      if @user.valid_password?(params[:user][:password]) && @user.is_active
        # ログイン成功時の処理（通常のログイン処理）
        sign_in(@user)
        redirect_to mypage_path
      elsif !@user.is_active
        # 停止状態のユーザーはログインできない
        flash[:notice] = "アカウントが停止されています"
      else
        # ログイン失敗時の処理
        flash[:notice] = "正しい情報を入力してください"
      end
    else
      # ユーザーが見つからない場合の処理
      flash[:notice] = "会員情報が見つからないため、再度会員登録をお願いします"
    end
  end


end
