class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show, :edit, :update]
  
  def index
    @users = User.where("apartment=?", current_user.apartment).order(id: :desc).page(params[:page]).per(25)
  end

  def show
    @user = User.find(params[:id])
    @post_show=Post.find_by(id: params[:id])
    @posts = @user.posts.order(id: :desc).page(params[:page])
    counts(@user)
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
    @user= User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = '更新されました'
      redirect_to @user
    else
      flash.now[:danger] = '更新されませんでした'
      render :edit
    end
  end

  def destroy
  end

  private

  def user_params
    params.require(:user).permit(:name, :sex, :age, :adress, :apartment, :introduction, :photo, :email, :password, :password_confirmation)
  end
  
end
