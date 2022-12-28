class Public::CommentsController < ApplicationController

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
      :reply_comment
      )
  end

end


