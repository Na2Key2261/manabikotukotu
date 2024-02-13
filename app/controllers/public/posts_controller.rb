
class Public::PostsController < ApplicationController
  def new
    @post = current_user.posts.build
    
  end

  def index
    @user = current_user
    @posts = Post.all.order(created_at: :desc).page(params[:page])
  end
  
  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
  end
  
  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      redirect_to public_user_path(current_user), notice: '投稿が成功しました。'
    else
      render :new
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

  private

  def post_params
    params.require(:post).permit(:learning_item, :learning_hour, :learning_content)
  end
end