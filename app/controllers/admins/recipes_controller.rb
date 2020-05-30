class Admins::RecipesController < ApplicationController
  before_action :authenticate_admin!
  def show
    @recipe=Recipe.find(params[:id])
    @recipe_image=RecipeImage.find(params[:id])
    @recipe_reviews=@recipe.recipe_reviews
    @recipe_images=@recipe.recipe_images
  end
  def destroy
    recipe=Recipe.find(params[:id])
    if recipe.destroy
      recipe.user.point -= 10
      recipe.user.save
      redirect_to admins_user_path(recipe.user)
    end
  end
end
