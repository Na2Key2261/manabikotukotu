
class Public::PostsController < ApplicationController
  before_action :check_guest, only: [:create, :update, :destroy]
  def new
    @post = current_user.posts.build

  end

  def index
    @user = current_user
    @posts = Post.all.order(created_at: :desc).page(params[:page])
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
        render :new
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
  
  def check_guest
    redirect_to root_path, alert: 'ゲストユーザーはこの操作を行えません。' if current_user.guest?
  end

  private

  def post_params
    params.require(:post).permit(:learning_item, :learning_hour, :learning_content)
  end
end