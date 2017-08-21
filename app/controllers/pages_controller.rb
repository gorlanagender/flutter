class PagesController < ApplicationController
  def index
    @posts = Post.where(user_id: User.find_by_username(params[:id]).id)
  end

  def home
    @posts = Post.where(user_id: current_user.id)
    @new_post = Post.new
  end

  def profile
    if User.find_by_username(params[:id])
      @user_name = params[:id]
    else
      redirect_to root_path, alert: "User not found"
    end
    @posts = Post.all.where(user_id: User.find_by_username(@user_name).id)
    @new_post = Post.new
  end

  def explore
    @posts = Post.all.where(user_id: current_user.id)
  end
end
