class Step < ApplicationRecord
  mount_uploader :image, RecipeImageUploader

  belongs_to :recipe
  validates :instruction, presence: true
end
