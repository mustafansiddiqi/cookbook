class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show]
  def show
    @user = User.find(params[:id])
    @recipes = if user_signed_in? && current_user == @user
                 @user.recipes.order(created_at: :desc)
               else
                 @user.recipes.published.order(created_at: :desc)
               end
  end
end
