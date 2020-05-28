class Users::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:edit, :update]

  def show
    @user=User.find(params[:id])
    @recipes=User.find(params[:id]).recipes.order(id: "DESC").page(params[:page]).per(4)
    @genres = Genre.all
    @categories = Category.all
    @currentUserEntry=Entry.where(user_id: current_user.id)
    @userEntry=Entry.where(user_id: @user.id)
    # roomsが作成されている場合と作成されていない場合に分ける
    unless @user.id == current_user.id
      @currentUserEntry.each do |cu|
        @userEntry.each do |u|
          # trueなら既に存在しており、作成されているroom_idを特定させる
          if cu.room_id == u.room_id then
            @isRoom = true
            @roomId = cu.room_id
          end
        end
      end
      # なければroomを作る必要がある
      unless @isRoom
        @room = Room.new
        @entry = Entry.new
      end
    end
  end

  def edit
    @user = User.find(params[:id])
    @genres = Genre.all
    @categories = Category.all
  end

  def update
    @user=User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id)
    else
      @genres=Genre.all
      @categories=Category.all
      render :edit
    end
  end
  def index
    @genres = Genre.all
    @categories = Category.all
    @user_pointrank = User.all.order(point: "desc").limit(5)
    @q = User.ransack(params[:q])
    @users = @q.result(distinct: true).page(params[:page]).per(5)
  end

  def explanation
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
    flash[:success] = "ありがとうございました。またのご利用を心よりお待ちしております。"
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

  private

  def user_params
    params.require(:user).permit(:name,:nickname,:sex,:phone_number,:image,allergy:[])
  end

  def correct_user
      @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
    end
  end
