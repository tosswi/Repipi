class RecipeReview < ApplicationRecord
  belongs_to :user
  belongs_to :recipe
  has_many :notifications, dependent: :destroy

  validates :recipe_comment, presence: true



end
