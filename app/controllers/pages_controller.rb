class PagesController < ApplicationController
  def index
    @posts = post_service.get_all_posts
  end

  def home
    @posts = post_service.get_posts
    @new_post = post_service.build_post
  end

  def profile
    @user = user_service.get_profile(name: params[:id])
    @posts = post_service.get_all_posts(user_id: @user.id)
    @new_post = post_service.build_post
    @users = user_service.get_top_users
  rescue Exceptions::UserExceptions::RecordNotFound
    redirect_to home_path, alert: 'User not found'
  end

  def explore
    @posts = post_service.get_all_posts
  end
end
