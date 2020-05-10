class PointsController < ApplicationController
  def create
    @user=User.find(params[:id]).
    
    @point.save

  end

  def destroy
  end

  def update
  end
end
