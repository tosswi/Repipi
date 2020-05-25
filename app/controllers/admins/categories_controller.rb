class Admins::CategoriesController < ApplicationController
  before_action :authenticate_admin!
  def create
      @category=Category.new(category_params)
    if @category.save
      redirect_to request.referer
    else
      render :index
    end
  end
  def index
    @categories=Category.all
    @category=Category.new
  end
  def edit
    @category=Category.find(params[:id])
  end
  def update
    @category=Category.find(params[:id])
    if @category.update(category_params)
      redirect_to admins_categories_path
    else
      render :index
    end
  end
  private
  def category_params
    params.require(:category).permit(:name)
  end
end
