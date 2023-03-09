class ListIngredient < ApplicationRecord
  belongs_to :list
  belongs_to :ingredient
end
