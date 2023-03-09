class AddCheckedToIngredient < ActiveRecord::Migration[6.0]
  def change
    add_column :ingredients, :checked, :boolean, default: false, null: false
  end
end
