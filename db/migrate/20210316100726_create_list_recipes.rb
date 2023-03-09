class CreateListRecipes < ActiveRecord::Migration[6.0]
  def change
    create_table :list_recipes do |t|
      t.references :list, null: false, foreign_key: true
      t.references :recipe, null: false, foreign_key: true

      t.timestamps
    end
  end
end
