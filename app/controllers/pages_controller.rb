class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    # if session[:visits] == 2
    #   session[:visits] = 0
    # else
    #   session[:visits] += 1
    # end
  end

  def dashboard
    @budget = params[:budget]


    # @counter = 0
    # @list = Recipe.all.sample(14)
    # @list.each do |recipe|
    #   ingredients = recipe.ingredients
    #   prices = ingredients.map { |ingredient| ingredient.price }
    #   @counter += prices.sum
    # end
    # @counter /= 4

    # @counter1 = 0
    # @list1 = Recipe.all.sample(14)
    # @list1.each do |recipe|
    #   ingredients = recipe.ingredients
    #   prices = ingredients.map { |ingredient| ingredient.price }
    #   @counter1 += prices.sum
    # end
    # @counter1 /= 4

    # @counter2 = 0
    # @list2 = Recipe.all.sample(14)
    # @list2.each do |recipe|
    #   ingredients = recipe.ingredients
    #   prices = ingredients.map { |ingredient| ingredient.price }
    #   @counter2 += prices.sum
    # end
    # @counter2 /= 4


    # all_recipes = []
    # 20.times do
    #   counter = 0
    # list = Recipe.all.sample(14)
    # list.each do |recipe|
    #   ingredients = recipe.ingredients
    #   prices = ingredients.map { |ingredient| ingredient.price }
    #   counter += prices.sum
    # end
    all_recipes = []
    20.times do
      counter = 0
      list = Recipe.where(breakfast: false).sample(14)
      list += Recipe.where(breakfast: true).sample(7)
      list.each do |recipe|
        ingredients = recipe.ingredients
        prices = ingredients.map { |ingredient| ingredient.price }
        counter += prices.sum
      end
    counter /= 4
    all_recipes << [list, counter]
    end
    @sorted_recipes = all_recipes.sort { |a,b| a[1] <=> b[1] }

    @i = 0
    @sorted_recipes.each do |recipe_list|
      break if recipe_list[1] > (@budget.to_i)*100
      @i += 1
    end
    @i
    @array_of_lists = []
    @array_of_lists << @sorted_recipes[@i-1]
    @array_of_lists << @sorted_recipes[@i-2]
    @array_of_lists << @sorted_recipes[@i-3]

    # @pictures = []
    # @sorted_recipes[@i-1][0].each do |recipe|
    #   # @pictures << recipe.picture
    #   @pictures << recipe.picture
    # end

    @pictures = []
    @breakfast_pictures = []
    @sorted_recipes[@i-1][0].sort!.each do |recipe|
      if recipe.breakfast == true
        @breakfast_pictures << recipe.picture
      else
        @pictures << recipe.picture
      end
    end

    @pictures1 = []
    @breakfast_pictures1 = []
    @sorted_recipes[@i-2][0].sort!.each do |recipe|
      if recipe.breakfast == true
        @breakfast_pictures1 << recipe.picture
      else
        @pictures1 << recipe.picture
      end
    end

    #  @pictures1 = []
    # @sorted_recipes[@i-2][0].each do |recipe|
    #   # @pictures << recipe.picture
    #   @pictures1 << recipe.picture
    # end

    @pictures2 = []
    @breakfast_pictures2 = []
    @sorted_recipes[@i-3][0].sort!.each do |recipe|
      if recipe.breakfast == true
        @breakfast_pictures2 << recipe.picture
      else
        @pictures2 << recipe.picture
      end
    end


    def save_list
      recipe_list = params[:recipes]
      new_list = List.create(user_id: current_user.id)
      recipe_list.each do |recipe|
        ListRecipe.create!(list_id: new_list.id, recipe_id: recipe.to_i)
      end
      redirect_to my_list_path
    end

    def my_list
      @list_waiting = params[:list_waiting]
      @chosen_list = current_user.lists.last
      @chosen_recipes = @chosen_list.recipes
      @chosen_breakfast = []
      @chosen_pictures = []
      @chosen_recipes.each do |recipe|
        if recipe.breakfast == true
          @chosen_breakfast << recipe.picture
        else
          @chosen_pictures << recipe.picture
        end
      end
      @chosen_counter = 0
      @chosen_recipes.each do |recipe|
        ingredients = recipe.ingredients
        prices = ingredients.map { |ingredient| ingredient.price }
        @chosen_counter += prices.sum
      end
      @chosen_counter /= 4

      # @recipe_names = []
      # @breakfast_names = []
      # @chosen_recipes.each do |recipe|
      #   if recipe.breakfast == true
      #     @breakfast_names << recipe.name
      #     raise
      #   else
      #     @recipe_names << recipe.name
      #   end
      # end

      @recipe_names = []
      @chosen_recipes.each do |recipe|
      @recipe_names << recipe.name
      end
      @recipes_names
    end



    # @pictures2 = []
    # @sorted_recipes[@i-3][0].each do |recipe|
    #   # @pictures << recipe.picture
    #   @pictures2 << recipe.picture
    # end


    # @price_list_1 = 0
    # @sorted_recipes[@i-1][0].each do |recipe|
    #   ingredients = recipe.ingredients
    #   prices = ingredients.map { |ingredient| ingredient.price }
    #   @price_list_1 += prices.sum
    # end
    # @price_list_1 /= 4



    # @array_price_list = []
    # @list_price = 0
    # @array_of_lists.each do |list|
    #   recipes = list.recipes
    #   recipes.each do |recipe|
    #     ingredients = recipe.ingredients
    #     prices = ingredients.map { |ingredient| ingredient.price }
    #     @list_price += prices.sum
    #   end
    #   @list_price /= 4
    #   @array_price_list << @list_price
    # end

    # @array = []
    # @list = Recipe.all.sample(14)
    # @list.each do |recipe|
    #   @array << recipe.ingredients[0].price
    # end
    # @array

    # @array = []
    # @array1 = []
    # @array2 = []
    # @counter1 = 0
    # @list = Recipe.all.sample(14)
    # @list.each do |recipe|
    #   @array << recipe.ingredients
    #   @array.each do |arr|
    #     @array1 << arr
    #     @array1.each do |ingred|
    #       @array2 << ingred
    #     end
    #   end
    # end
    # @array2
    # @counter1


    #@price = current_user.budget
    #if Date.today.yday - (current_user.lists.last.created_at.yday) > 7
      #@list =
      #@list =
      #@list =
    #else
    #end
  end

  # def destroy_list
  #   @list = List.find(params[:id])
  #   @list.destroy
  #   redirect_to root_path
  # end
end
