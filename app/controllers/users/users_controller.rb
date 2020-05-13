class Users::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :allergy_string, only: [:create, :update]
  def show
    @user=User.find(params[:id])
    @recipes=User.find(params[:id]).recipes.order(id: "DESC").page(params[:page]).per(4)
    @genres = Genre.all
    @categories = Category.all
    @users=User.all
  end

  def edit
    @user=User.find(params[:id])
    @genres = Genre.all
    @categories = Category.all
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
    @genres = Genre.all
    @categories = Category.all
    @user_pointrank = User.all.order(point: "desc").limit(6)
    @user_weekrank=@user_pointrank.where("updated_at >= ?", Time.zone.now.beginning_of_day)
    @q = User.ransack(params[:q])
    @users = @q.result(distinct: true).page(params[:page]).per(3)
  end
  def following
      @user  = User.find(params[:id])
      @users = @user.following
      render 'show_follow'
  end
  def hide
    #is_member_statusカラムにフラグを立てる(defaultはfalse)
    current_user.update(is_member_status: true)
    #ログアウトさせる
    reset_session
    flash[:notice] = "ありがとうございました。またのご利用を心よりお待ちしております。"
    redirect_to root_path
  end

  def followers
    @user  = User.find(params[:id])
    @users = @user.followers
    render 'show_follower'
  end
  def followerindex
    @user=User.find(params[:user_id])
  end
  def followindex
    @user=User.find(params[:user_id])
  end
  def allergy_string
    params[:user][:allergy] = params[:user][:allergy]&.join("/")  # to string
  end
  private
  def user_params
    params.require(:user).permit(:name,:nickname,:sex,:phone_number,:image,allergy:[])
  end

end
