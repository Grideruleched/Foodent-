class AddPriceToIngredient < ActiveRecord::Migration[6.0]
  def change
    add_column :ingredients, :price, :integer
  end
end
