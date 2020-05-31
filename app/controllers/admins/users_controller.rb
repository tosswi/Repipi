class Admins::UsersController < ApplicationController
  before_action :authenticate_admin!
  def index
    @users=User.order(id: "DESC").page(params[:page]).per(10)
    @genres = Genre.all
    @categories = Category.all
  end

  def show
    @user=User.find(params[:id])
    @genres = Genre.all
    @categories = Category.all
    @recipes=User.find(params[:id]).recipes
    @users=User.all
  end

  def edit
    @user=User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to admins_users_path
  end
  private
  def user_params
    params.require(:user).permit(:name,:nickname,:sex,:phone_number,:image,:is_member_status,allergy:[])
  end
end
