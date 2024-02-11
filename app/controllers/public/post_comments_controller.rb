class Public::PostCommentsController < ApplicationController
  def create
    post = Post.find(params[:post_id])
    comment = current_user.post_comments.new(post_comment_params)
    comment.post_id = post.id
    comment.save
    redirect_to public_post_path(post)
  end
  
  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.post_comments.find(params[:id])
    if @comment.destroy
      flash[:success] = "コメントが削除されました。"
    else
      flash[:error] = "コメントの削除中にエラーが発生しました。"
    end
    redirect_to public_user_path # Redirect to wherever you want
  end
  
  private
  
  def post_comment_params
     params.require(:post_comment).permit(:comment)
  end
end
