class NotificationsController < ApplicationController
  before_action :authenticate_user!
  def index
    #未確認の通知レコードだけ取り出したあと、「未確認→確認済」になるように更新
    @notifications = current_user.passive_notifications.page(params[:page]).per(20)
    @notifications.where(checked: false).each do |notification|
      notification.update_attributes(checked: true)
    end
    @categories=Category.all
    @genres=Genre.all
  end
end
