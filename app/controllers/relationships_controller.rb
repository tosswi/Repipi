class RelationshipsController < ApplicationController
  before_action :authenticate_user!
  def follow
    current_user.follow(params[:follow_id])
    redirect_to root_path
  end
  
  def unfollow
    current_user.unfollow(params[:follow_id])
    redirect_to root_path
  end

  def create
    @user = User.find(params[:follow_id])
    following = current_user.follow(@user)
    if following.save
      @user.point += 3
      @user.save 
      @user.create_notification_follow!(current_user)
      flash[:success] = 'ユーザーをフォローしました'
      redirect_to request.referer
    else
      flash.now[:alert] = 'ユーザーのフォローに失敗しました'
      redirect_to request.referer
    end
  end

  def destroy
    @user = User.find(params[:follow_id])
    following = current_user.unfollow(@user)
    if following.destroy
      @user.point -= 3
      @user.save 
      flash[:success] = 'ユーザーのフォローを解除しました'
      redirect_to request.referer
    else
      flash.now[:danger] = 'ユーザーのフォロー解除に失敗しました'
      redirect_to request.referer
    end
  end
end
