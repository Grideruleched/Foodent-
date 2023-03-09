class AddBooleanToRecipe < ActiveRecord::Migration[6.0]
  def change
    add_column :recipes, :breakfast, :boolean, default: false
  end
end
