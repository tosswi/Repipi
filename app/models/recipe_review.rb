class RecipeReview < ApplicationRecord
  belongs_to :user
  belongs_to :recipe
  has_many :notifications, dependent: :destroy

  validates :recipe_comment, length: { maximum: 1000 }, presence: true
  validates :rate, numericality: {
    less_than_or_equal_to: 5,
    greater_than_or_equal_to: 1
  }, presence: true

end
