class ListIngredientsController < ApplicationController
   def update
    @list_ingredient = ListIngredient.find(params[:id])
    @list_ingredient.update(list_ingredient_params)
  end
        private

def list_ingredient_params
  params.require(:list_ingredient).permit(:checked)
  end
end
