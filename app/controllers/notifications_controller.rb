class NotificationsController < ApplicationController
  def index
    @notifications = current_user.passive_notifications.page(params[:page]).per(10)
    #未確認の通知レコードを取り出した後、未確認→確認済みになるように
    @notifications.where(checked: false).each do |notification|
      notification.update_attributes(checked: true)
    end
  end
end
