class Admin::CommentsController < ApplicationController

  def index
    @comments= Comment.all.page(params[:page]).per(12)
  end


 
  def destroy
    Comment.find(params[:id]).destroy
    redirect_to  admin_comments_path
  end


  private

  def comment_params
    params.require(:comment).permit(
      :comment,
      :reply_comment,
      :user_id,
      :recipe_id
      )
  end

end

