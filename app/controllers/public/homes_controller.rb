class Public::HomesController < ApplicationController


  def top
    @recipes= Recipe.all
    @amount= Recipe.count
  end

end
