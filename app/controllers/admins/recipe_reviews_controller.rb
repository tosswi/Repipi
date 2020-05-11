class Admins::RecipeReviewsController < ApplicationController
  def destroy
    recipe_review=RecipeReview.find_by(params[:recipe_id])
    if  recipe_review.destroy
        recipe_review.user.point -= 5
        recipe_review.user.save
        redirect_to admins_path
    else
      redirect_to admins_path
    end
  end
end
