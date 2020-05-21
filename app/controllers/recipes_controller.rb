class RecipesController < ApplicationController
  before_action :authenticate_user!, except:[:index,:top]
  before_action :correct_user, only: [:edit, :update]
  def top
    @recipes_all=Recipe.all
  end

  def new
    @recipe=Recipe.new
    # buildで最初から空の明細が1つ表示させれる
    @recipe.materials.build
    @recipe.recipe_images.build
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
    # @recipes=Recipe.all.includes(:user)
    @recipes_all=Recipe.all
    @recipe_images=RecipeImage.all
    @recipes_bookmark = Recipe.find(Bookmark.group(:recipe_id).order('count(recipe_id) desc').limit(5).pluck(:recipe_id))
  # User.all.order(point: "desc").limit(6)
  # @rank_items = OrderItem.find(OrderItem.group(:item_id).order('count(quantity) desc').limit(3).pluck(:id))
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
  
  def upload_file
    recipe = Recipe.find_by_id(params[:id])
    @recipe_images = recipe_images.create(recipe_params)
  end

  def create
    @recipe=Recipe.new(recipe_params)
    @recipe.user_id = current_user.id
    @genres = Genre.all
    @categories = Category.all
    if @recipe.save
      @recipe.user.point += 20
      @recipe.user.save
      flash[:success] = "レシピを投稿しました。"
      redirect_to recipe_path(@recipe)
    else
      flash.now[:danger] = "レシピの投稿に失敗しました。"
      render :new 
    end
  end
  def edit
    @recipe=Recipe.find(params[:id])
  end
  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    flash[:success] = "レシピを削除しました。"
    redirect_to recipes_path
  end
  def update
    @recipe=Recipe.find(params[:id])
    if @recipe.update(recipe_params)
      flash[:success] = "レシピの編集しました。"
      redirect_to recipe_path(@recipe)
    else
      flash.now[:danger] = "レシピの編集に失敗しました。"
      render :edit
    end
  end
  def bookmarks
    @genres = Genre.all
    @categories = Category.all
    @recipes = current_user.bookmark_recipes.includes(:user)
  end
  private
  def recipe_params #imageはプロフィール画像
    params.require(:recipe).permit(:name,:content,:material,:quantity,:human,:playtime,:image,:genre_id,:user_id,:category_id,:is_recipe_status, recipe_images_attributes: [:recipe_image], materials_attributes: [:id,:name,:quantity,:_destroy])
  end
  def recipe_image_params #レシピ画像
    params.require(:recipe_image).permit(:recipe_image)
  end
  def correct_user
    @recipe = Recipe.find(params[:id])
    redirect_to(root_url) unless current_user?(@recipe.user)
  end
end
