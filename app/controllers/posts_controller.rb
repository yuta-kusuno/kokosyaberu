class PostsController < ApplicationController
  before_action :require_user_logged_in, only: [:new, :show, :create, :edit, :update, :destroy]
  before_action :correct_user, only: [:destroy]
  
  def index
    if logged_in?
      @posts_apartment = Post.joins(:user).where("apartment=?", current_user.apartment).order(id: :desc).page(params[:page])
      @posts = Post.order(id: :desc).page(params[:page])
      @post = Post.new
    else
      @posts = Post.order(id: :desc).page(params[:page])
      @post = Post.new
    end
    
  end
  
  def new
    
  end
  
  def show
    @post=Post.find_by(id: params[:id])
    @comments=Comment.where(post_id: @post.id)
    @comment=Comment.new
  end
  
  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      flash[:success] = '投稿しました。'
      redirect_to root_url
    else
      @posts = current_user.posts.order(id: :desc).page(params[:page])
      flash.now[:danger] = '投稿できません。'
      render :new
    end
  end
  
  def edit
    @post = Post.find_by(id: params[:id])
    @user= User.find_by(id: params[:id])
  end

  def update
    @post= Post.find(params[:id])
    if @post.update(post_params)
      flash[:success] = '更新されました'
      redirect_to current_user
    else
      flash.now[:danger] = '更新されませんでした'
      render :edit
    end
  end

  def destroy
    @post=Post.find(params[:id])
    @post.destroy
    flash[:success] = '削除しました。'
    redirect_to posts_url
  end
  
  private

  def post_params
    params.require(:post).permit(:content, :datetime, :place)
  end
  
  def correct_user
    @post = current_user.posts.find_by(id: params[:id])
    unless @post
      redirect_to root_url
    end
  end
end
