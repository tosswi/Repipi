class Admins::RecipeReviewsController < ApplicationController
  def destroy
    recipe_review=RecipeReview.find_by(params[:recipe_id])
    if  recipe_review.destroy
        redirect_to request.referer
    else
      redirect_to request.referer
    end
  end
end
