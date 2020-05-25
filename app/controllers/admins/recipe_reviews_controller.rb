class Admins::RecipeReviewsController < ApplicationController
  before_action :authenticate_admin!
  def destroy
    recipe_review=RecipeReview.find_by(params[:recipe_id])
    recipe_review.destroy
    redirect_to request.referer
  end
end
