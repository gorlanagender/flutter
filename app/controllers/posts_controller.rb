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

  private

  def post_params
    params.require(:post).permit(:content)
  end

end