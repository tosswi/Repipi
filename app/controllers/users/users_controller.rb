class Users::UsersController < ApplicationController
  before_action :allergy_string, only: [:create, :update]
  def show
    @user=User.find(params[:id])
    @recipes=User.find(params[:id]).recipes
        @genres = Genre.all
    @categories = Category.all
    @users=User.all
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
        @genres = Genre.all
    @categories = Category.all
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
  def allergy_string
    params[:user][:allergy] = params[:user][:allergy].join("/")  # to string
  end
  private
  def user_params
    params.require(:user).permit(:name,:nickname,:sex,:phone_number,:image,allergy:[])
  end

end
