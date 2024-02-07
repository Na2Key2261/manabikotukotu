class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  def show
    @user = current_user
    @post = Post.new
    @user_name = @user.name
    @posts = @user.posts
    @posts = Post.all.order(created_at: :desc)
    
  end
end
