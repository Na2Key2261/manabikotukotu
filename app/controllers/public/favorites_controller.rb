class Public::FavoritesController < ApplicationController
  def index
    @user = current_user
    @favorite_posts = @user.favorites.map(&:post).sort_by(&:created_at).reverse
  end

  def create
    post = Post.find(params[:post_id])
    favorite = current_user.favorites.new(post_id: post.id)
    favorite.save
    redirect_back(fallback_location: public_posts_path)  # 元の投稿が表示されているページにリダイレクト
  end

  def destroy
    post = Post.find(params[:post_id])
    favorite = current_user.favorites.find_by(post_id: post.id)
    favorite.destroy
    redirect_back(fallback_location: public_posts_path)  # 元の投稿が表示されているページにリダイレクト
  end
end