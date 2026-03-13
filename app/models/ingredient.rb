class Ingredient < ApplicationRecord
  belongs_to :recipe

  UNITS = {
    cup:   0,
    oz:    1,
    tbsp:  2,
    tsp:   3,
    grams: 4,
    ml:    5,
    whole: 6
  }.freeze

  enum :unit, UNITS

  def scaled_amount(ratio)
    (amount * ratio).round(2)
  end

  validates :name, :amount, :unit, presence: true
end
