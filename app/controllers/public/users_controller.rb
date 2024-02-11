class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  def show
  @user = current_user
  @post = Post.new
  @user_name = @user.name
  @posts = @user.posts.order(created_at: :desc) # ユーザーの投稿のみを取得し、降順で表示する
  end
  
  def edit
  @user = User.find(params[:id])
  end
  
  def update
    @user = current_user
    
    if @user.update(user_params)
      bypass_sign_in(@user) # ログインし直す
      redirect_to mypage_path, notice: 'ユーザー情報が更新されました。'
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
