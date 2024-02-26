class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  
  def show
  @user = current_user
  @post = Post.new
  @user_name = @user.name
   # ユーザーの投稿のみを取得し、降順で表示する
  @posts = @user.posts.order(created_at: :desc).page(params[:page]).per(5)

  # 学習時間の合計
  @total_learning_hours = @user.posts.sum(:learning_hour)

# 日付を指定して学習時間の合計と学習項目を取得
  if params[:search_date].present?
    search_date = Date.parse(params[:search_date])
    posts_on_date = @user.posts.where(created_at: search_date.all_day)
    @total_learning_hours_on_date = posts_on_date.sum(:learning_hour)
    @learning_items_on_date = posts_on_date.group(:learning_item).sum(:learning_hour)
  end  
  # 当日の学習時間の合計と学習項目
    today_posts = @user.posts.where(created_at: Date.today.all_day)
    @total_today_learning_hours = today_posts.sum(:learning_hour)
    @learning_items_today = today_posts.group(:learning_item).sum(:learning_hour)

    # 前日の学習時間の合計と学習項目
    yesterday_posts = @user.posts.where(created_at: 1.day.ago.all_day)
    @total_yesterday_learning_hours = yesterday_posts.sum(:learning_hour)
    @learning_items_yesterday = yesterday_posts.group(:learning_item).sum(:learning_hour)
  

  # 学習項目別の学習時間の合計
  @learning_items_total = @user.posts.group(:learning_item).sum(:learning_hour)

  # 過去一週間の学習時間
start_date = Date.today.beginning_of_week(:sunday) - 6.days
end_date = Date.today.end_of_week(:sunday)
weekly_learning_hours = @user.posts.where(created_at: start_date..end_date).group("DATE(created_at)").sum(:learning_hour)

@weekly_learning_hours = []
(start_date..Date.today).reverse_each do |date|
  formatted_date = date.strftime("%Y-%m-%d")
  @weekly_learning_hours << { date: formatted_date, hours: weekly_learning_hours[formatted_date] || 0 }
end

# 過去一週間の学習時間の合計
@total_weekly_hours = @weekly_learning_hours.sum { |data| data[:hours] }

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
