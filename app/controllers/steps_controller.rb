class StepsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_recipe
  before_action :require_owner!

  def create
    @step = @recipe.steps.build(step_params)
    if @step.save
      redirect_to edit_recipe_path(@recipe), notice: "Step added."
    else
      redirect_to edit_recipe_path(@recipe), alert: @step.errors.full_messages.to_sentence
    end
  end

  def update
    @step = @recipe.steps.find(params[:id])
    if @step.update(step_params)
      redirect_to edit_recipe_path(@recipe), notice: "Step updated."
    else
      redirect_to edit_recipe_path(@recipe), alert: @step.errors.full_messages.to_sentence
    end
  end

  def destroy
    @recipe.steps.find(params[:id]).destroy
    redirect_to edit_recipe_path(@recipe), notice: "Step removed."
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:recipe_id])
  end

  def require_owner!
    redirect_to root_path, alert: "Not authorized." unless @recipe.user == current_user
  end

  def step_params
    params.require(:step).permit(:position, :instruction, :image)
  end
end
