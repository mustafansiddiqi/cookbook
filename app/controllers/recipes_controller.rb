class RecipesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :set_recipe, only: [:show, :edit, :update, :destroy]
  before_action :require_owner!, only: [:edit, :update, :destroy]

  def index
    @recipes = Recipe.published.order(created_at: :desc)
  end

  def show
    @servings = (params[:servings] || @recipe.base_servings).to_i
    @ratio    = @servings.to_f / @recipe.base_servings
  end

  def new
    @recipe = current_user.recipes.build
  end

  def create
    @recipe = current_user.recipes.build(recipe_params)
    if @recipe.save
      redirect_to @recipe, notice: "Recipe created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @recipe.update(recipe_params)
      redirect_to @recipe, notice: "Recipe updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @recipe.destroy
    redirect_to recipes_path, notice: "Recipe deleted."
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def require_owner!
    redirect_to root_path, alert: "Not authorized." unless @recipe.user == current_user
  end

  def recipe_params
    params.require(:recipe).permit(
      :title, :description, :base_servings, :prep_time_mins, :cook_time_mins,
      :cover_image, :cover_image_cache, :status,
      ingredients_attributes: [:id, :name, :amount, :unit, :_destroy],
      steps_attributes:       [:id, :instruction, :image, :_destroy]
    )
  end
end
