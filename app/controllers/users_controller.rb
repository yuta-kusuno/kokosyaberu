class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show, :edit, :update]
  
  def index
    @users = User.order(id: :desc).page(params[:page]).per(25)
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = '新規登録しました。'
      redirect_to @user
    else
      flash.now[:danger] = '新規登録に失敗しました。'
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
  end

  def destroy
  end
  
  private

  def user_params
    params.require(:user).permit(:name, :adress, :apartment, :email, :password, :password_confirmation)
  end
  
end
