class RecipeReview < ApplicationRecord
  belongs_to :user
  belongs_to :recipe
  has_many :notifications, dependent: :destroy

  validates :recipe_comment, length: { maximum: 1000 }, presence: true



end
