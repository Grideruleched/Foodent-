class CreateListIngredients < ActiveRecord::Migration[6.0]
  def change
    create_table :list_ingredients do |t|
      t.boolean :checked
      t.references :list, null: false, foreign_key: true
      t.references :ingredient, null: false, foreign_key: true

      t.timestamps
    end
  end
end
