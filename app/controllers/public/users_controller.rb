class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_guest_user, only: [:edit]
  def show
  @user = current_user
  @post = Post.new
  @user_name = @user.name
  @posts = @user.posts.order(created_at: :desc) # ユーザーの投稿のみを取得し、降順で表示する
  @posts = @user.posts.page(params[:page])

  # 学習時間の合計
  @total_learning_hours = @user.posts.sum(:learning_hour)

  # 学習項目別の学習時間の合計
  @learning_items_total = @user.posts.group(:learning_item).sum(:learning_hour)

  # 過去一週間の学習時間
  start_date = Date.today.beginning_of_week(:sunday) - 6.days
  end_date = Date.today.end_of_week(:sunday)
  weekly_learning_hours = @user.posts.where(created_at: start_date..end_date).group("DATE(created_at)").sum(:learning_hour)

  @weekly_learning_hours = []
  (start_date..Date.today).each do |date|
    formatted_date = date.strftime("%Y-%m-%d")
    @weekly_learning_hours << { date: formatted_date, hours: weekly_learning_hours[formatted_date] || 0 } if weekly_learning_hours[formatted_date]
  end

  @chart_data = [['学習項目', '学習時間']]
  @learning_items_total.each do |learning_item, total_hours|
    @chart_data << [learning_item, total_hours]
  end
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
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :image)
  end
  
  
end
