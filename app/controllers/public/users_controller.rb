class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  def show
    @user = current_user
    @post = Post.new
    @posts = @user.posts
  end
end
