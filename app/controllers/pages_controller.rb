class PagesController < ApplicationController
  def index
    @posts = Post.where(user_id: User.find_by_username(params[:id]).id)
  end

  def home
    @posts = Post.where(user_id: User.find_by_username(params[:id]).id)
  end

  def profile
    if User.find_by_username params[:id]
      @user_name = params[:id]
    else
      redirect_to root_path, alert: "User not found"
    end
    @posts = Post.where(user_id: User.find_by_username(params[:id]).id)
  end

  def explore
    @posts = Post.where(user_id: User.find_by_username(params[:id]).id)
  end
end
