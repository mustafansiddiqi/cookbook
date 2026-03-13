class SavedRecipesController < ApplicationController
  before_action :authenticate_user!

  def index
    @recipes = current_user.saved.order(created_at: :desc)
  end

  def create
    recipe = Recipe.find(params[:id])
    current_user.saved_recipes.find_or_create_by(recipe: recipe)
    redirect_back fallback_location: recipe_path(recipe)
  end

  def destroy
    recipe = Recipe.find(params[:id])
    current_user.saved_recipes.find_by(recipe: recipe)&.destroy
    redirect_back fallback_location: recipe_path(recipe)
  end
end
