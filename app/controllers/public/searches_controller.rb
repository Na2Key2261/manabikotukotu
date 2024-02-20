class Public::SearchesController < ApplicationController
  before_action :authenticate_user!
  

  def search
  @method = params[:search_type]

  return if @method.blank?

  if @method == 'learning_item'
    @posts = Post.where(learning_item: params[:learning_item]).order(created_at: :desc)
  elsif @method == 'learning_content'
    @posts = Post.where('learning_content LIKE ?', "%#{params[:learning_content]}%").order(created_at: :desc)
  end
end


end
