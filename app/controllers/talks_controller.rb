class TalksController < ApplicationController
  before_action :require_user_logged_in
  
  def index
    @user=current_user
    @users=User.where("apartment = ? and id != ?", @user.apartment, @user.id)
    @talks=Talk.where("user_id = ? or receive_user_id = ?", @user.id, @user.id)
  end
  
  def show
    @user = User.find(params[:id])
    send_id = current_user.talks.where(receive_user_id: @user.id)
    receive_id = @user.talks.where(receive_user_id: current_user.id)
    @talks = Talk.where(id: send_id + receive_id).order(created_at: :desc)
    @talk = Talk.new
  end

  def create
    @user=User.find(params[:user_id])
    @talk = current_user.talks.new(talk_params)
    @talk.receive_user_id = @user.id
    if @talk.save
      flash[:success] = '送信しました。'
      #ここから通知レコード
      @talk.create_notification_talk!(current_user, @talk.id)
      #ここまで
      redirect_back(fallback_location: root_path)
    else
      flash[:danger] = '送信できませんでした。'
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    @talk = Talk.find(params[:id])
    @talk.destroy
    flash[:success] = '削除しました。'
    redirect_back(fallback_location: root_path)
  end

  private

  def talk_params
    params.require(:talk).permit(:content)
  end
  
end
