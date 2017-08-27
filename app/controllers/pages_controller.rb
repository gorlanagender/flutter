class PagesController < ApplicationController
  def index
    @posts = post_service.get_all_posts
  end

  def home
    @posts = post_service.get_posts
    @new_post = post_service.build_post
  end

  def profile
    @user = User.find_by_username(params[:id])
    if @user
      @user_name = params[:id]
    else
      redirect_to root_path, alert: "User not found"
    end
    @posts = post_service.get_all_posts(user_id: @user.id)
    @new_post = post_service.build_post
    @users = post_service.get_top_users
  end

  def explore
    @posts = post_service.get_all_posts
  end
end
