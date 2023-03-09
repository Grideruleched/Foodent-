class IngredientsController < ApplicationController
  def shopping_list
    # @recipes = current_user.lists.last.recipes
    # @ingredients = []
    # @recipes.each do |recipe|
    #   @ingredients << recipe.recipe_ingredients
    # end
    # @recipes = Recipe.where(user: current_user)
    # @list = current_user.lists.last
    @list = List.find(params[:id])
    @quantity_ingredients = session[:data]
    # @list_ingredients = @list.list_ingredients
  end
  def create_list_ingredients
    @list = List.find(params[:id])
    @recipes = @list.recipes
    @recipe_ingredients = @recipes.map {|recipe| recipe.recipe_ingredients}.flatten
    quantity_ingredients = {}
    @recipe_ingredients.each do |recipe_ingredient|
      unless quantity_ingredients.key?(recipe_ingredient.ingredient.name)
        quantity_ingredients[recipe_ingredient.ingredient.name] = [0, nil]
      end
      if ['g', 'gr'].include?(recipe_ingredient.unit)
        unit = 'kg'
        quantity = (recipe_ingredient.quantity.to_i / 1000) + 1
      elsif recipe_ingredient.unit == 'cl'
        unit = 'l'
        quantity = (recipe_ingredient.quantity.to_i / 1000) + 1
      else
        unit = recipe_ingredient.unit
        quantity = recipe_ingredient.quantity.to_i
      end
      quantity_ingredients[recipe_ingredient.ingredient.name][1] = unit
      quantity_ingredients[recipe_ingredient.ingredient.name][0] += quantity
    end

    # @ingredients = @recipes.map {|recipe| recipe.ingredients}.flatten
    @list_ingredients = []
    quantity_ingredients.each do |name, quantity_unit|
      list_ingredient = ListIngredient.create(list: @list, ingredient: Ingredient.find_by(name: name), checked: false)
      @list_ingredients << list_ingredient
    end
    session[:data] = quantity_ingredients
    redirect_to shopping_list_path(@list)
  end
end
