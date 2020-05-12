class BookmarksController < ApplicationController
  before_action :authenticate_user!
  def  index
  end
  def create
    recipe = Recipe.find(params[:recipe_id])
    bookmark = current_user.bookmarks.build(recipe_id: params[:recipe_id])
    bookmark.save
    recipe.user.point += 20
    recipe.user.save
    recipe.create_notification_bookmark!(current_user)
    redirect_to request.referer, success: t('.flash.bookmark')
  end

  def destroy
    recipe = Recipe.find(params[:recipe_id])
    if recipe.bookmark_by?(current_user)
    current_user.bookmarks.find_by(recipe_id: params[:recipe_id]).destroy!
    recipe.user.point -= 20
    recipe.user.save
    redirect_to request.referer, success: t('.flash.not_bookmark')
    end
  end
  def update
  end
end
