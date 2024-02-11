class Public::SearchesController < ApplicationController
  before_action :authenticate_user!
  
  def search
    @content = params[:content]
    @method = params[:method]
    if @method == 'post'
      @posts = Post.search_for(@content, @method)
    elsif @method == 'learning_item'
      @users = User.search_for(@content, @method)
    end
  end
end
