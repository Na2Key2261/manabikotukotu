class Public::PostsController < ApplicationController
  def new
    @post = current_user.posts.build
    
  end

  def index
    @posts = Post.all.order(created_at: :desc)
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
  
  def destroy
    PostComment.find(params[:id]).destroy
    redirect_to public_post_path(params[:post_id])
  end 

  private

  def post_params
    params.require(:post).permit(:learning_item, :learning_hour, :learning_content)
  end
end