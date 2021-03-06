class RecipeReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:edit, :update]
  def create
    @recipe = Recipe.find(params[:recipe_id])
    @recipe_review = @recipe.recipe_reviews.new(recipe_review_params)
    @recipe_review.user_id = current_user.id
    if @recipe_review.save
      @recipe.create_notification_recipe_review(current_user, @recipe_review.id)
      redirect_to recipe_path(@recipe)
    else
      @recipe=Recipe.find(params[:recipe_id])
      @recipe_reviews=@recipe.recipe_reviews
      @recipe_images=@recipe.recipe_images
      @genres=Genre.all
      @categories=Category.all
      render '/recipes/show'
    end
  end

  def edit
    @recipe_review=RecipeReview.find(params[:recipe_id])
  end

  def update
    @recipe_review=RecipeReview.find(params[:recipe_id])
    if @recipe_review.update(recipe_review_params)
      redirect_to recipe_path(@recipe_review.recipe,@recipe_review)
    else
      render :edit
    end
  end
  
  def destroy
    @recipe_review = RecipeReview.find(params[:recipe_id])
    if @recipe_review.user != current_user
      redirect_to request.referer 
    end
    @recipe_review.destroy
    redirect_to recipe_path(@recipe_review.recipe,@recipe_review)
  end

  private

  def recipe_review_params
    params.require(:recipe_review).permit(:recipe_comment,:recipe_review,:rate,:recipe_id,:user_id)
  end

  def correct_user
    @recipe_review = RecipeReview.find(params[:recipe_id])
    redirect_to(root_url) unless current_user?(@recipe_review.user)
  end
end
