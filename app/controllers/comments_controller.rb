class CommentsController < ApplicationController
  before_action :require_user_logged_in
  
  def create
    @post=Post.find(params[:post_id])
    @comment=@post.comments.new(comment_params)
    @comment.user_id=current_user.id
    if @comment.save
      flash[:success] = '送信しました。'
      #ここから通知レコード
      @post.create_notification_comment!(current_user, @comment.id)
      #ここまで
      redirect_back(fallback_location: root_path)
    else
      flash[:danger] = '送信できませんでした。'
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    @comment=Comment.find(params[:id])
    @comment.destroy
    flash[:success]='削除しました。'
    redirect_back(fallback_location: root_path)
  end
  
  private
  
  def comment_params
    params.require(:comment).permit(:body)
  end
  
end
