class RecipesController < ApplicationController

  def index
    @recipes = Recipe.all
  end

  def show
    @recipe = Recipe.find(params[:id])
    # @array_eric
    # @listeric = Recipe.all.each do |recipe|
    #   @array_eric << recipe.ingredients
    # end
  end

  def search_recipes
    if params[:query].present?
      @recipes = Recipe.search_recipes(params[:query])
    else
      render :index
    end
end

end
