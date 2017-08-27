class PostsController < ApplicationController

  def new
    @post = post_service.build_post
  end

  def create
    respond_to do |format|
      format.html {
      if post_service.create_post(attrs: post_params)
        redirect_to home_path, notice: "Post saved successfully"
      else
        redirect_to home_path, notice: "Post not saved"
      end
      }
    end
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