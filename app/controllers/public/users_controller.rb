class Public::UsersController < ApplicationController
  def show
   @user= User.find(params[:id])
   @recipe = @user.recipes

   favorites = Favorite.where(user_id: current_user.id).pluck(:recipe_id)
   @favorite_list = Recipe.find(favorites)
  end

  def edit
   @user= User.find(params[:id])
  end

  def update
    @user= current_user
    if @user.update(user_params)
      redirect_to public_user_path
    else
      render "edit"
    end
  end

  def quit #退会画面を表示するアクション
   @user = User.find(params[:id])
  end

  def out
    current_user.update(is_deleted: true)
    reset_session
    redirect_to root_path
  end

  private
  def user_params
    params.require(:user).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :email,:is_deleted)
  end

end

