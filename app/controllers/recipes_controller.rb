class RecipesController < ApplicationController
  before_action :set_genres, only: [:index, :new, :edit, :create,:update]
  before_action :set_categories, only: [:index, :new, :edit, :create,:update]
  def top
  end
  def new
    @recipe=Recipe.new
    @genres = Genre.all
    @categories = Category.all
  
  end
  def show
    @recipe=Recipe.find(params[:id])
    @recipe_review=RecipeReview.new
    @recipe_reviews=@recipe.recipe_reviews
  end
  def  index
    @recipes=Recipe.all.includes(:user)
    @recipe_all=Recipe.all

    # @rank_recipes = Recipe.find(Recipe.group(:).order('count() desc').limit(3).pluck(:id))
  end
  def upload_file
    recipe = Recipe.find_by_id(params[:id])
    @recipe_images = recipe_images.create(recipe_params)
  end



  def create
    @recipe=Recipe.new(recipe_params)
    @recipe.user_id = current_user.id
    if @recipe.save
      redirect_to recipes_path
    else
      render :new
    end
  end
  def edit
    @recipe=Recipe.find(params[:id])
  end
  def destroy
  end
  def update
    @recipe=Recipe.find(params[:id])
    if @recipe.update(recipe_params)
      redirect_to recipes_path
    else
      render :new
    end
  end
  def bookmarks
    @recipes = current_user.bookmark_recipes.includes(:user)
  end
  private
  def recipe_params
    params.require(:recipe).permit(:name,:content,:material,:quantity,:human,:playtime,:image,:genre_id,:user_id,:category_id,)
  end
  def set_genres
    @genres = Genre.all
  end
  def set_categories
    @categories = Category.all
  end
end
