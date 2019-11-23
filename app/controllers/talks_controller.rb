class TalksController < ApplicationController
  before_action :require_user_logged_in
  
  def show
    @user = User.find_by(id: params[:user_id])
    send_ids = current_user.talks.where(receive_user_id: @user.id)
    receive_ids = @user.talks.where(receive_user_id: current_user.id)
    @talks = Talk.where(id: send_ids + receive_ids).order(created_at: :desc)
    @talk = Talk.new
  end

  def create
    @user=User.find(params[:user_id])
    @talk = current_user.talks.new(talk_params)
    @talk.receive_user_id = @user.id
    if @talk.save
      flash[:success] = '送信しました。'
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
