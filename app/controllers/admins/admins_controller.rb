class Admins::AdminsController < ApplicationController
  before_action :authenticate_admin!
  def top
    @users = User.where("created_at >= ?", Time.zone.now.beginning_of_day)
    @recipes = Recipe.where("created_at >= ?", Time.zone.now.beginning_of_day)
  end
end
