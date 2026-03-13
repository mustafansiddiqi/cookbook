module RecipesHelper
  def serving_ratio(recipe, desired_servings)
    desired_servings.to_f / recipe.base_servings
  end
end
