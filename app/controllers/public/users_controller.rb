class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  def show
    @user = current_user
    @post = Post.new
    @user_name = @user.name
    @posts = @user.posts
  end
end
