class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!
  def index
    @posts = Post.all.includes(:user)
  end

  def edit
    @post = Post.find(params[:id])
  end
  
  def show
    @post = Post.find(params[:id])
  end
end
