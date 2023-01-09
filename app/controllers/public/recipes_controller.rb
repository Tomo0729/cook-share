class Public::RecipesController < ApplicationController

  before_action :authenticate_user!, only: [:new, :edit, :create, :update, :destroy]
  def index
    @recipes = params[:tag_id].present? ? Tag.find(params[:tag_id]).recipes : Recipe.all
    if user_signed_in?
      @recipes = @recipes.includes([:user], [:favorites]).page(params[:page]).per(12)
    else
      @recipes = @recipes.includes([:user]).page(params[:page]).per(12)
    end
     @amount= Recipe.count
     @comment = Comment.new

    if user_signed_in?
      @comment = current_user.comments.new(flash[:comment])
      @comment_reply = current_user.comments.new
    end
  end

  def show
    @recipes = params[:tag_id].present? ? Tag.find(params[:tag_id]).recipes : Recipe
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
    tag_list = params[:recipe][:tag_id].split(nil)
    if recipe.save
      recipe.save_recipes(tag_list)
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
    redirect_to public_recipes_path(current_user.id)
  end

  def search
    @recipe = Recipe.search(params[:keyword])
  end

  def tag_search
    @tag = Tag.find(params[:tag_id])
    @recipes = @tag.recipes.includes([:user], [:favorites])
  end


  private


    def recipe_params
      params.require(:recipe).permit(
        :image,
        :name,
        :introduction,
        :user_id,
        tag_ids: [],
        ingredients_attributes: [:id, :name, :quantity, :_destroy],
        cook_steps_attributes: [:id, :direction, :image, :_destroy],
        tags_attributes: [:id, :tag_name],tags_ids: []
      )
    end
end
