class RecipePolicy < ApplicationPolicy
  # Anyone can browse the index and view published recipes.
  def index?  = true
  def show?   = record.published? || owner?

  # Only signed-in users can create.
  def new?    = authenticated?
  def create? = authenticated?

  # Only the owner can edit or delete.
  def edit?    = owner?
  def update?  = owner?
  def destroy? = owner?

  # Saving / unsaving a recipe requires being signed in (but not the owner).
  def save?   = authenticated?
  def unsave? = authenticated?
end
