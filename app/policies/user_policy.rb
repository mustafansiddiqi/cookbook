class UserPolicy < ApplicationPolicy
  # Anyone can view a profile.
  def show? = true

  # Only the account owner can edit their own profile.
  def edit?   = user == record
  def update? = user == record
end
