
class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_user, only: [:edit, :update]

  def index
    @users = User.all
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    if @user.update(user_params)
      redirect_to admin_users_path, notice: 'ユーザー情報を更新しました。'
    else
      render :edit
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :status)
  end
end
