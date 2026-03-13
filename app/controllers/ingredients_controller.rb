class IngredientsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_recipe
  before_action :require_owner!

  def create
    @ingredient = @recipe.ingredients.build(ingredient_params)
    if @ingredient.save
      redirect_to edit_recipe_path(@recipe), notice: "Ingredient added."
    else
      redirect_to edit_recipe_path(@recipe), alert: @ingredient.errors.full_messages.to_sentence
    end
  end

  def update
    @ingredient = @recipe.ingredients.find(params[:id])
    if @ingredient.update(ingredient_params)
      redirect_to edit_recipe_path(@recipe), notice: "Ingredient updated."
    else
      redirect_to edit_recipe_path(@recipe), alert: @ingredient.errors.full_messages.to_sentence
    end
  end

  def destroy
    @recipe.ingredients.find(params[:id]).destroy
    redirect_to edit_recipe_path(@recipe), notice: "Ingredient removed."
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:recipe_id])
  end

  def require_owner!
    redirect_to root_path, alert: "Not authorized." unless @recipe.user == current_user
  end

  def ingredient_params
    params.require(:ingredient).permit(:name, :amount, :unit, :position)
  end
end
