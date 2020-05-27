class NotificationsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @notifications = current_user.passive_notifications.page(params[:page]).per(10)
        #未確認の通知レコードだけ取り出したあと、「未確認→確認済」になるように更新
    @notifications.where(checked: false).each do |notification|
    notification.update_attributes(checked: true)
    end
    @categories=Category.all
    @genres=Genre.all
  end

  def destroy_all
    @notification_destroy_all = Notification.all
    @notification_destroy_all.destroy_all
    flash[:notice] = "通知を全て削除いたしました。"
    redirect_to request.referer
  end
end
