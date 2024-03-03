
class Public::PostsController < ApplicationController
  before_action :check_guest_user, only: [:new, :create, :edit, :update, :destroy]
  def new
    @post = current_user.posts.build
  end

  def index
    @user = current_user
    @posts = Post.order(created_at: :desc).page(params[:page])
    @total_learning_hours = @posts.sum(:learning_hour)

  @learning_hours_by_item = @posts.group(:learning_item).sum(:learning_hour)
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
  end

  def create
    if current_user
      @post = current_user.posts.build(post_params)

      if @post.save
        redirect_to public_user_path(current_user), notice: '投稿が成功しました。'
      else
        redirect_to public_user_path(current_user), alert: '各項目を記入してください。'
      end
    else
      redirect_to new_user_session_path, alert: 'ログインが必要です。'
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to public_user_path(current_user), notice: '投稿が更新されました。'
    else
      render :edit
    end
  end

  def destroy

    @post = Post.find(params[:id])
    if @post.destroy
      flash[:notice] = "投稿が削除されました。"
    else
      flash[:alert] = "投稿の削除に失敗しました。"
    end
    redirect_to public_user_path(current_user)
  end
  
  def check_guest_user
    if current_user.email == "guest@example.com"
      redirect_to root_path, alert: "ゲストユーザーはこの操作を行うことができません。"
    end
  end

  private

  def post_params
    params.require(:post).permit(:learning_item, :learning_hour, :learning_content)
  end
end