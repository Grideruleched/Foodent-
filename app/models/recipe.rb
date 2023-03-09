class Recipe < ApplicationRecord
  has_many :recipe_ingredients
  has_many :ingredients, through: :recipe_ingredients
  has_many :list_recipes
include PgSearch::Model
  pg_search_scope :search_recipes,
    against: [ :name, :description, :preparation ],
    using: {
      tsearch: { prefix: true }
    }

  def display_ingredients
    recipe_ingredients.map do |ri|
      "#{ri.quantity} #{ri.ingredient.name}"
    end
  end
end
