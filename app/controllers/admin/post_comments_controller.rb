
    class Admin::PostCommentsController < ApplicationController
      def destroy
        @post_comment = PostComment.find(params[:id])
        @post_comment.destroy
        redirect_to admin_post_path(@post_comment.post), notice: 'コメントが削除されました'
      end
    end