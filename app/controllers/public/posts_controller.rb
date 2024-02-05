class Public::PostsController < ApplicationController
  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      redirect_to public_user_path(current_user), notice: '投稿が成功しました。'
    else
      render :new
    end
  end

  private

  def post_params
    params.require(:post).permit(:learning_item, :learning_hour, :learning_content)
  end
end