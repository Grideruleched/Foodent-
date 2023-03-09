# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# 5.times do
#   url = "https://www.themealdb.com/api/json/v1/1/random.php"
#   meal = JSON.parse(open(url).read)["meals"].first
#   recipe = Recipe.create(
#     name: meal["strMeal"],
#     description: meal[""],
#     picture:meal["mealThumb"],
#     rating: (1..5).to_a.sample,
#     preparation: meal["strInstructions"],
#   )
#   # POur chaque ingredient (on suppose 20 au max)
#   20.times do |i|
#     # Je récupère le nom de l'ingrédient
#     ingredient = meal["strIngredient#{i}"] # "Aubergine"
#     # Si y'a un nom
#     if !ingredient.blank?
#       # Je regarde si je connais cet ingrédient en DB
#       db_ingredient = Ingredient.find_by_name(ingredient)
#       # Si je le connais pas
#       if !db_ingredient
#         # Je le crée
#         db_ingredient = Ingredient.create(
#           name: ingredient
#         )
#       end

#       ri = RecipeIngredient.create(
#         recipe: recipe,
#         ingredient: db_ingredient,
#         quantity: meal["strMeasure#{i}"]
#       )
#       p ri
#     end
#   end
# end


require 'json'
require 'open-uri'
require "nokogiri"

ListRecipe.destroy_all
RecipeIngredient.destroy_all
ListIngredient.destroy_all
Recipe.destroy_all


html = open("https://www.marmiton.org/recettes/index/categorie/plat-principal?rcp=0").read
# 1. Parse HTML
doc = Nokogiri::HTML(html, nil, "utf-8")
# 2. For the first five results

doc.search(".recipe-card").first(60).each do |element|
  # 3. Create recipe and store it in results
  name = element.search(".recipe-card__title").first.text.strip
  recipe_url = element.search(".recipe-card-link").first.attributes["href"].value
  rating = element.search(".recipe-card__rating__value").first.text.strip
  prep_time = element.search(".recipe-card__duration__value").first.text.strip

  recipe_html = open(URI.escape(recipe_url)).read
  recipe_doc = Nokogiri::HTML(recipe_html, nil, "utf-8")

  description = recipe_doc.search(".recipe-step-list").first.text.strip

  # recherche de la photo pour chaque recettes ici :
  p picture = recipe_doc.search("#recipe-picture-print").first.attributes["src"].value
  recipe = Recipe.create(name: name, description: description, picture: picture, rating: rating, cooking_time: prep_time)
  recipe_url

  recipe_doc.search(".ingredient-list__ingredient-group li").each do |ingredient|
    ingredient_name =  ingredient.search(".item__ingredient .ingredient-name").first.text.strip
    ingredient_quantity = ingredient.search(".item__quantity .quantity").first.text.strip
    ingredient_unit = ingredient.search(".item__quantity .unit").first.text.strip
    if !ingredient_name.blank?
      # Je regarde si je connais cet ingrédient en DB
      db_ingredient = Ingredient.find_by_name(ingredient_name)
      # Si je le connais pas
      # p ingredient_name
      html = open(URI.escape("https://www.carrefour.fr/s?q=#{ingredient_name.parameterize}")).read
      doc_price = Nokogiri::HTML(html, nil, "utf-8")

      scrap_ingredient = doc_price.search(".ds-product-card--vertical.ds-product-card:not(.ds-product-card--shimmer)").first


      if scrap_ingredient.nil?
        ingredient_price = 100
      else
        ingredient_price = (scrap_ingredient.search(".ds-title.product-card-price__price--final").first.text.strip.gsub(",", ".").to_f)*100.to_i
      end
        # document.querySelector(".ds-product-card--vertical.ds-product-card:not(.ds-product-card--shimmer)").querySelector(".ds-title.product-card-price__price--final")


      if !db_ingredient
        # Je le crée
        db_ingredient = Ingredient.create(
          name: ingredient_name,
          price: ingredient_price
          # price: ( ingredient_price / rand(1..2) )
        )
      end

      ri = RecipeIngredient.create(
        recipe: recipe,
        ingredient: db_ingredient,
        quantity: ingredient_quantity,
        unit: ingredient_unit
      )
      p ri
    end
  end
end


# 1 breakfast (bol de cereales + lait)

boldecereales = Recipe.create(name: "3 céréales URSS", description: "Céréales du parti comuniste de Vladimir Poutine, vous rendront riche et beau... à consommer avec du lait frais (et de la vodka pour les vrais bonhommes)", picture: "boldecereales.jpg", rating: 2, cooking_time: "5 min", breakfast: true)
cerealescrunchy = Ingredient.create(name: "Céréales 3 chocolats", price: 8)
lait = Ingredient.create(name: "lait demi-écrémé", price: 4)
recipebreakfast = RecipeIngredient.create(recipe: boldecereales, ingredient: cerealescrunchy, quantity: "100", unit: "gr")
recipebreakfast1 = RecipeIngredient.create(recipe: boldecereales, ingredient: lait, quantity: "50", unit: "cl")

petitprince = Recipe.create(name: "French biscuit", description: "Biscuit petit prince trempé 3 fois dans un bol de lait... Et n'éclabousse pas quand il tombe dans le bol parce qu'il est trop mou...", picture: "petitprince.jpg", rating: 4, cooking_time: "7 min", breakfast: true)
biscuitpetitprince = Ingredient.create(name: "Petit prince", price: 12)
lait = Ingredient.create(name: "lait demi-écrémé", price: 4)
recipepetitprince = RecipeIngredient.create(recipe: petitprince, ingredient: biscuitpetitprince, quantity: "150", unit: "gr")
recipepetitprince1 = RecipeIngredient.create(recipe: petitprince, ingredient: lait, quantity: "50", unit: "cl")

zumbacafew = Recipe.create(name: "Café noir, (le vrai)", description: "Vous avez du mal à vous réveiller le matin? Pas de problème, avec le café noir de la marque Zumba cafew, vous allez pouvoir optimiser votre journée de travail tout en dansant la zumba coréene. (à consommer avec modératation !!!)", picture: "cafew.jpg", rating: 5, cooking_time: "30 sec", breakfast: true)
cafew = Ingredient.create(name: "Café en grain de Corée", price: 8)
eau = Ingredient.create(name: "L'eau", price: 0)
recipecafew = RecipeIngredient.create(recipe: zumbacafew, ingredient: cafew, quantity: "300", unit: "gr")
recipecafew1 = RecipeIngredient.create(recipe: zumbacafew, ingredient: eau, quantity: "1", unit: "l")

tartinedesavoie = Recipe.create(name: "La tramontane", description: "Sur une tartine de pain rassis, étalez du coulomier de premier choix avec de la confiture de fraise et des lardons", picture: "tartinedesavoie.jpg", rating: 1, cooking_time: "10 min", breakfast: true)
pain = Ingredient.create(name: "Pain rassis", price: 0)
coulomier = Ingredient.create(name: "Coulomier", price: 12)
confituredefraise = Ingredient.create(name: "Confiture de fraise", price: 8)
lardons = Ingredient.create(name: "Lardons", price: 4)
cafew = Ingredient.create(name: "Café en grain de Corée", price: 8)
eau = Ingredient.create(name: "L'eau", price: 0)
recipetartinedesavoie = RecipeIngredient.create(recipe: tartinedesavoie, ingredient: cafew, quantity: "300", unit: "gr")
recipetartinedesavoie1 = RecipeIngredient.create(recipe: tartinedesavoie, ingredient: eau, quantity: "1", unit: "l")
recipetartinedesavoie2 = RecipeIngredient.create(recipe: tartinedesavoie, ingredient: coulomier, quantity: "100", unit: "gr")
recipetartinedesavoie3 = RecipeIngredient.create(recipe: tartinedesavoie, ingredient: confituredefraise, quantity: "20", unit: "gr")
recipetartinedesavoie4 = RecipeIngredient.create(recipe: tartinedesavoie, ingredient: pain, quantity: "100", unit: "gr")

kingbreakfast = Recipe.create(name: "Le repas des rois", description: "Inspirez profondément et expirez doucement, répétez cette technique 3 fois et ... c'est bon vous n'avez plus faim ! Bonne journée !!!", picture: "kingbreakfast.jpg", rating: 1, cooking_time: "2 min", breakfast: true)
seum = Ingredient.create(name: "Du seum", price: 0)
recipekingbreakfast = RecipeIngredient.create(recipe: kingbreakfast, ingredient: seum, quantity: "3", unit: "co2")

pancakenutella = Recipe.create(name: "Pancake nutella", description: "Pancake délicieux avec une couche généreuse de nutella, rien de mieux pour prendre 20 kg.. (pour votre santé, n'oubliez pas de manger 5 fruits et légumes par jours)", picture: "pancakenutella.jpg", rating: 5, cooking_time: "15 min", breakfast: true)
farine = Ingredient.create(name: "Farine de blé", price: 4)
nutella = Ingredient.create(name: "Nutella (pas celui qui favorise la déforestation)", price: 5)
oeuf = Ingredient.create(name: "Oeuf de cocque", price: 4)
sucre = Ingredient.create(name: "Sucre en poudre", price: 4)
lait = Ingredient.create(name: "lait demi-écrémé", price: 4)
recipepancakenutella = RecipeIngredient.create(recipe: pancakenutella, ingredient: farine, quantity: "20", unit: "gr")
recipepancakenutella1 = RecipeIngredient.create(recipe: pancakenutella, ingredient: sucre, quantity: "10", unit: "gr")
recipepancakenutellat2 = RecipeIngredient.create(recipe: pancakenutella, ingredient: lait, quantity: "50", unit: "cl")
recipepancakenutellat3 = RecipeIngredient.create(recipe: pancakenutella, ingredient: oeuf, quantity: "2", unit: "unité")
recipepancakenutellat4 = RecipeIngredient.create(recipe: pancakenutella, ingredient: nutella, quantity: "100", unit: "gr")

veganbreakfast = Recipe.create(name: "Le vegan breakfast", description: "Cultivé de père en fils sur l'une des terres les plus banales de poitou-charentes, dégustez une herbe de qualité ferti-ligiène.. Bon appétit !!!", picture: "veganbreakfast.jpg", rating: 4, cooking_time: "15 min", breakfast: true)
herbebanal = Ingredient.create(name: "Herbe d'origine protégée", price: 4)
terre = Ingredient.create(name: "Terre de qualité ferti-ligiène", price: 12)
recipevegan = RecipeIngredient.create(recipe: veganbreakfast, ingredient: herbebanal, quantity: "200", unit: "gr")
recipevegan1 = RecipeIngredient.create(recipe: veganbreakfast, ingredient: terre, quantity: "300", unit: "gr")


