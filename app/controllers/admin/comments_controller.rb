class Admin::CommentsController < ApplicationController

  def index
    @comments= Comment.all.page(params[:page]).per(12)
  end

  def show
    @comment= Comment.find(params[:id]).page(params[:page]).per(12)
  end

  def edit
    @comment= Comment.find(params[:id]).page(params[:page]).per(12)
  end

  def destroy
    @comment= Comment.find(params[:id])
    @comment.destroys(comment_params)
    redirect_to admin_comments_path(current_user.id)
  end


  def create
    recipe = Recipe.find(params[:recipe_id])
    comment = current_user.comments.new(comment_params)
    comment.recipe_id = recipe.id
    if comment.save
    redirect_to  public_recipe_path(@recipe)
    else
      redirect_to root_path
    end
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

