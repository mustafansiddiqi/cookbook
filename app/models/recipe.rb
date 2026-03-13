class Recipe < ApplicationRecord
  mount_uploader :cover_image, CoverImageUploader

  belongs_to :user
  has_many :ingredients,   -> { order(:position) }, dependent: :destroy
  has_many :steps,         -> { order(:position) }, dependent: :destroy
  has_many :recipe_images, -> { order(:position) }, dependent: :destroy
  has_many :saved_recipes, dependent: :destroy

  enum :status, { draft: 0, published: 1 }

  accepts_nested_attributes_for :ingredients, allow_destroy: true
  accepts_nested_attributes_for :steps,       allow_destroy: true

  validates :title, :base_servings, presence: true
end
