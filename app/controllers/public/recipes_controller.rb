class Public::RecipesController < ApplicationController

  before_action :authenticate_user!, only: [:new, :edit, :create, :update, :destroy]
  def index

    @recipes = params[:tag_id].present? ? Tag.find(params[:tag_id]).recipes : Recipe
    if user_signed_in?
      @recipes = @recipes.includes([:user], [:favorites]).page(params[:page]).per(12)
    else
      @recipes = @recipes.includes([:user]).page(params[:page]).per(12)
    end

     @comment = Comment.new

    if user_signed_in?
      @comment = current_user.comments.new(flash[:comment])
      @comment_reply = current_user.comments.new
    end
  end

  def show

    @recipe = Recipe.find(params[:id])

    @comment = Comment.new
 
  end

  def new
    @recipe = Recipe.new(flash[:recipe])
    @recipe.ingredients.build
    @recipe.cook_steps.build
  end

  def edit
    @recipe = Recipe.find(params[:id])


  end

  def create
    @recipe = Recipe.new(recipe_params)
    recipe = current_user.recipes.new(recipe_params)

    if recipe.save
      redirect_to public_recipe_path(recipe)
    else
      redirect_to new_public_recipe_path, flash: {
        recipe: recipe,
        error_messages: recipe.errors.full_messages
      }
    end
  end

  def update
    @recipe= Recipe.find(params[:id])
    @recipe.update(recipe_params)
    redirect_to public_recipe_path(@recipe)
  end

  def destroy
    @recipe= Recipe.find(params[:id])
    @recipe.destroy
    redirect_to public_user_path(current_user.id)
  end

  def search
    if user_signed_in?
      @recipes = @q.result(distinct: true).includes([:favorites]).page(params[:page]).per(6)
    else
      @recipes = @q.result(distinct: true).includes([:user]).page(params[:page]).per(6)
    end
    @search = params[:q][:title_or_ingredients_content_cont]
  end

  def tag_search
    @tag = Tag.find(params[:tag_id])
    @recipes = @tag.recipes.includes([:user], [:favorites])
  end

  private
    def set_recipe
      @recipe = Recipe.find(params[:id])
    end

    def set_q
      @q = Recipe.ransack(params[:q])
    end

    # Only allow a list of trusted parameters through.
    def recipe_params
      params.require(:recipe).permit(
        :image,
        :name,
        :introduction,
        :user_id,
        tag_ids: [],
        ingredients_attributes: [:id, :name, :quantity, :_destroy],
        cook_steps_attributes: [:id, :direction, :image, :_destroy]
      )
    end
end
