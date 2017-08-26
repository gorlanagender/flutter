class PagesController < ApplicationController
  def index
    @posts = post_service.get_all_posts
  end

  def home
    @posts = post_service.get_all_posts
    @new_post = post_service.build_post
  end

  def profile
    if User.find_by_username(params[:id])
      @user_name = params[:id]
    else
      redirect_to root_path, alert: "User not found"
    end
    @posts = post_service.get_all_posts
    @new_post = post_service.build_post
  end

  def explore
    @posts = post_service.get_all_posts
  end
end
