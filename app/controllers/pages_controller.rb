class PagesController < ApplicationController
  def index
    explore
  end

  def home
    @posts = present(data: post_service.get_posts, presenter: PostsPresenter)
    @new_post = post_service.build_post
  end

  def profile
    @user = user_service.get_profile(name: params[:id])
    @posts = present(data: post_service.get_all_posts(user_id: @user.id),
                     presenter: PostsPresenter)
    @new_post = post_service.build_post
    @users = user_service.get_top_users
  rescue Exceptions::UserExceptions::RecordNotFound
    redirect_to home_path, alert: 'User not found'
  end

  def explore
    @news = api_service.get_news
  end
end
