class RecipesController < ApplicationController
  before_action :authenticate_user!, except:[:index,:top]
  before_action :correct_user, only: [:edit, :update]
  def top
    @recipes_all=Recipe.all
  end

  def new
    @recipe=Recipe.new
    # buildで最初から空のformが1つ表示させれる
    @recipe.materials.build
    4.times{@recipe.recipe_images.build}
    @genres = Genre.all
    @categories = Category.all
  end
  def show
    @genres=Genre.all
    @categories=Category.all
    @recipe=Recipe.find(params[:id])
    @recipe_review=RecipeReview.new
    @recipe_image=RecipeImage.find(params[:id])
    @recipe_reviews=@recipe.recipe_reviews
    @recipe_images=@recipe.recipe_images
  end
  def  index
    @recipes_all=Recipe.all
    @recipe_images=RecipeImage.all
    @recipes_bookmark = Recipe.find(Bookmark.group(:recipe_id).order('count(recipe_id) desc').limit(5).pluck(:recipe_id))
    @categories=Category.all
    @genres=Genre.all
    if params[:category_id]
    @category=Category.find(params[:category_id])
    @recipes = @category.recipes
  end
    if params[:genre_id]
    @genre=Genre.find(params[:genre_id])
    @recipes = @genre.recipes
  end
  end

  def self.search(search)
    if search
      Recipe.where(['name LIKE ?', "%#{search}%"])
    else
      Recipe.all 
    end
  end

  def create
    @recipe=Recipe.new(recipe_params)
    @genres = Genre.all
    @categories = Category.all
    @recipe.user_id = current_user.id
    if @recipe.save
      @recipe.user.point += 20
      @recipe.user.save
      flash[:success] = "レシピを投稿しました。"
      redirect_to recipe_path(@recipe)
    else
      4.times{@recipe.recipe_images.build}
      flash.now[:danger] = "レシピの投稿に失敗しました。"
      render :new 
    end
  end
  def edit
    @recipe=Recipe.find(params[:id])
    4.times do |i|
      if @recipe.recipe_images[i].blank?
        @recipe.recipe_images.build
      end
    end
    @genres=Genre.all
    @categories=Category.all
  end
  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    flash[:success] = "レシピを削除しました。"
    redirect_to recipes_path
  end
  def update
    @recipe=Recipe.find(params[:id])
    @recipe.recipe_images.destroy_all
    if @recipe.update(recipe_params)
      flash[:success] = "レシピの編集しました。"
      redirect_to recipe_path(@recipe)
    else
      @genres = Genre.all
      @categories = Category.all
      flash.now[:danger] = "レシピの編集に失敗しました。"
      redirect_to edit_recipe_path(@recipe)
    end
  end
  def bookmarks
    @genres = Genre.all
    @categories = Category.all
    @recipes = current_user.bookmark_recipes.includes(:user)
  end
  private
  def recipe_params #imageはプロフィール画像
    params.require(:recipe).permit(:name,:content,:material,:quantity,:human,:playtime,:image,:genre_id,:user_id,:category_id,:is_recipe_status, recipe_images_attributes: [:id,:recipe_image], materials_attributes: [:id,:name,:quantity,:_destroy])
  end

  def correct_user
    @recipe = Recipe.find(params[:id])
    redirect_to(root_url) unless current_user?(@recipe.user)
  end
end
