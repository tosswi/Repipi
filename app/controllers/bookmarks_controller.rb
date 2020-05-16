class BookmarksController < ApplicationController
  before_action :authenticate_user!
  def  index
  end
  def create
    recipe = Recipe.find(params[:recipe_id])
    bookmark = current_user.bookmarks.build(recipe_id: params[:recipe_id])
    bookmark.save
    recipe.user.point += 10
    recipe.user.save
    recipe.create_notification_bookmark!(current_user)
    flash[:success] = "ブックマークに登録しました"
    redirect_to request.referer
  end

  def destroy
    recipe = Recipe.find(params[:recipe_id])
    if recipe.bookmark_by?(current_user)
    current_user.bookmarks.find_by(recipe_id: params[:recipe_id]).destroy!
    recipe.user.point -= 20
    recipe.user.save
    flash[:success] = "ブックマークを解除しました"
    redirect_to request.referer
    end
  end
  def update
  end
end
