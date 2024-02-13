class Public::SearchesController < ApplicationController
  before_action :authenticate_user!


  def search
    @content = params[:content]
    @method = params[:search_type]
  
    # ログに出力して @method の値を確認する
    logger.info "Search type: #{@method}"
  
    # contentが空の場合は検索を行わずに終了
    return if @content.blank?
  
    if @method == 'learning_item'
      @users = User.looks(params[:method], @content)
  
      # @users の値をログに出力して確認する
      logger.info "@users: #{@users.inspect}"
    elsif @method == 'learning_content'
      @posts = Post.search_for(@content, params[:method])
    end
  end
end
