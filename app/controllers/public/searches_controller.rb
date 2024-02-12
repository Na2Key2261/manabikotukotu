class Public::SearchesController < ApplicationController
  before_action :authenticate_user!
  
  
  def search
    @content = params[:content]
    @method = params[:search_type]
    
    # contentが空の場合は検索を行わずに終了
    return if @content.blank?

    if @method == 'learning_item'
      @users = User.looks(params[:method], @content)
    elsif @method == 'learning_content'
      @posts = Post.search_for(@content, params[:method])
    end
  end
end
