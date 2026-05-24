class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show]
  before_action :set_user, only: [:show]

  def show
    authorize! @user
    @recipes = if user_signed_in? && current_user == @user
                 @user.recipes.order(created_at: :desc)
               else
                 @user.recipes.published.order(created_at: :desc)
               end
  end

  def my_profile
    redirect_to user_path(current_user)
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
