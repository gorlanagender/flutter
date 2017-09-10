class PostsController < ApplicationController

  def new
    @post = post_service.build_post
  end

  def create
    @post = post_service.create_post(attrs: post_params)
    respond_to do |format|
      format.html { redirect_to home_path, notice: 'Post saved successfully' }
    end
  rescue ActiveRecord::RecordInvalid => e
    redirect_to home_path, alert: "Post not saved - #{e.message}"
  end

  def follow
   post_service.follow_user(attrs: follow_params)
   redirect_to request.referrer
  end

  def un_follow
   post_service.unfollow_user(attrs: follow_params)
   redirect_to request.referrer
  end

  private

  def post_params
    params.require(:post).permit(:content)
  end

  def follow_params
    params.permit(:followed_id)
  end

end