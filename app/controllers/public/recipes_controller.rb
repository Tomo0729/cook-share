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
    @recipe.tag_relations.build
  end

  def edit
    @recipe = Recipe.find(params[:id])
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user_id = current_user.id
    if @recipe.save
      redirect_to public_recipe_path(@recipe)
    else
      render "new"
    end
  end

  def update
    @recipe= Recipe.find(params[:id])
    
    if @recipe.update(recipe_params)
      redirect_to public_recipe_path(@recipe)
    else
      render "edit"
    end
  end

  def destroy
    @recipe= Recipe.find(params[:id])
    @recipe.destroy
    redirect_to public_recipes_path(current_user.id)
  end


  def search
    @keyword = params[:keyword]
    @search = params[:keyword]
    @recipe = Recipe.search(@keyword)
     render "search"
  end



  def tag_search
    @recires = params[:tag_id].present? ? Tag.find(params[:tag_id]).recipes : Recipe.all
    @tag=Tag.find(params[:tag_id])
    @tag_search = params[:tag_name]
    @recipes=@tag.recipes.page(params[:page]).per(8)
    render "tag_search"
  end


  private



    def recipe_params
      params.require(:recipe).permit(
        :image,
        :name,
        :introduction,
        :user_id,
        ingredients_attributes: [:id, :name, :quantity, :_destroy],
        cook_steps_attributes: [:id, :direction, :image, :_destroy],
        tag_relations_attributes: [:id, :tag_id, :_destroy],
        tag_ids: []
      )
    end
end
