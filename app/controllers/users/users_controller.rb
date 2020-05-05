class Users::UsersController < ApplicationController
  def show
    @user=User.find(params[:id])
    @recipes=User.find(params[:id]).recipes
  end
  def edit
    @user=User.find(params[:id])
  end
  def update
    @user=User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end
  def index
    @users=User.all
  end
  def following
      @user  = User.find(params[:id])
      @users = @user.following
      render 'show_follow'
  end

  def followers
    @user  = User.find(params[:id])
    @users = @user.followers
    render 'show_follower'
  end
  private
  def user_params
    params.require(:user).permit(:name,:nickname,:sex,:allergy_id,:phone_number,:image)
  end
end
