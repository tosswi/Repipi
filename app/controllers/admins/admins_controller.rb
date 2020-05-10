class Admins::AdminsController < ApplicationController
  def top
    @users = User.where("created_at >= ?", Time.zone.now.beginning_of_day)
    @recipes = Recipe.where("created_at >= ?", Time.zone.now.beginning_of_day)
  end
end
