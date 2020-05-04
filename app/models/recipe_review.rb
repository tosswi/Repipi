class RecipeReview < ApplicationRecord
  belongs_to :user
  belongs_to :recipe
  has_many :notifications
  ratyrate_rateable "recipe_review"

end
