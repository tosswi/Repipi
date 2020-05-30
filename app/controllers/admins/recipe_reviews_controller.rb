class Admins::RecipeReviewsController < ApplicationController
  before_action :authenticate_admin!
  def destroy
    recipe_review=RecipeReview.find_by(params[:recipe_id])
    recipe_review.destroy
    redirect_to admins_recipe_path(recipe_review.recipe,recipe_review)
  end
end
