class Public::SearchsController < ApplicationController

  def index
      @recipes = Recipe.search(params[:keyword])
      @recipe= Recipe.all.page(params[:page]).per(12)
      @search_word = params[:keyword]
  end
end
