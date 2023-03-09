class CreateRecipes < ActiveRecord::Migration[6.0]
  def change
    create_table :recipes do |t|
      t.string :name
      t.text :description
      t.string :picture
      t.integer :rating
      t.string :cooking_time
      t.integer :price
      t.text :preparation

      t.timestamps
    end
  end
end
