class BookmarksController < ApplicationController
  def  index
  end
  def create
    bookmark = current_user.bookmarks.build(recipe_id: params[:recipe_id])
    bookmark.save!
    redirect_to recipes_path, success: t('.flash.bookmark')
  end
  def destroy
    current_user.bookmarks.find_by(recipe_id: params[:recipe_id]).destroy!
    redirect_to recipes_path, success: t('.flash.not_bookmark')
  end
  def update
  end
end
