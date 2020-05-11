class Admins::RecipesController < ApplicationController
    def show
        @recipe=Recipe.find(params[:id])
        @recipe_image=RecipeImage.find(params[:id])
        @recipe_reviews=@recipe.recipe_reviews
        @recipe_images=@recipe.recipe_images
    end
    def destroy
        recipe=Recipe.find(params[:id])
        if  recipe.destroy
            recipe.user.point -= 5
            recipe.user.save
            redirect_to admins_path
        end
    end
end
