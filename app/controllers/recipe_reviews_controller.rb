class RecipeReviewsController < ApplicationController
  def create
    @recipe = Recipe.find(params[:recipe_id])
    @recipe_review = @recipe.recipe_reviews.new(recipe_review_params)
    @recipe_review.user_id = current_user.id
    if @recipe_review.save
      redirect_to recipe_path(@recipe)
    else
      @recipe_review = RecipeReview.where(recipe_id: @recipe.id)
      render '/recipes/show'
    end
  end
  def destroy
    @recipe_review = RecipeReview.find(params[:recipe_id])
    if @recipe_review.user != current_user
      redirect_to request.referer
    end
    @recipe_review.destroy
    redirect_to request.referer
  end
  private
  def recipe_review_params
    params.require(:recipe_review).permit(:recipe_comment,:recipe_review,:recipe_id,:user_id)
  end
end
