class FollowsController < ApplicationController
  before_action :authenticate_user!

  def create
    user = User.find(params[:user_id])
    current_user.active_follows.find_or_create_by(followed: user) unless user == current_user
    redirect_back fallback_location: user_path(user)
  end

  def destroy
    user = User.find(params[:user_id])
    current_user.active_follows.find_by(followed: user)&.destroy
    redirect_back fallback_location: user_path(user)
  end
end
