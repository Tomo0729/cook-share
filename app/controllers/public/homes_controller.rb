class Public::HomesController < ApplicationController


  def top
    @recipes= Recipe.order("created_at DESC").page(params[:page]).per(12)
    @amount= Recipe.count
  end



end
