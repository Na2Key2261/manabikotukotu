class Public::SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    @method = params[:search_type]
  
    # ログに出力して @method の値を確認する
    logger.info "Search type: #{@method}"
  
    if @method == 'learning_item'
      @posts = Post.where(learning_item: params[:learning_item])
  
      # @posts の値をログに出力して確認する
      logger.info "@posts: #{@posts.inspect}"
    elsif @method == 'learning_content'
      @posts = Post.where('learning_content LIKE ?', "%#{params[:learning_content]}%")
    end
  end
end
