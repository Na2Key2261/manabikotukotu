class Public::PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to root_path, notice: '学習情報が投稿されました。'
    else
      render :new
    end
  end

  private

  def post_params
    params.require(:post).permit(:learning_item, :learning_hour, :learning_content)
  end
end