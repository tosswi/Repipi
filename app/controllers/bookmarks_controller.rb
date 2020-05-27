class BookmarksController < ApplicationController
  before_action :authenticate_user!

  def create
    recipe = Recipe.find(params[:recipe_id])
    bookmark = current_user.bookmarks.build(recipe_id: params[:recipe_id])
    bookmark.save
    if current_user != recipe.user
      recipe.user.point += 10
      recipe.user.save
    end
    recipe.create_notification_bookmark(current_user)
    flash[:success] = "ブックマークに登録しました"
    redirect_to request.referer
  end

  def destroy
    recipe = Recipe.find(params[:recipe_id])
    if recipe.bookmark_by?(current_user)
      current_user.bookmarks.find_by(recipe_id: params[:recipe_id]).destroy!
      if current_user != recipe.user
        recipe.user.point -= 10
        recipe.user.save
      end
      flash[:success] = "ブックマークを解除しました"
      redirect_to request.referer
    end
  end
end
