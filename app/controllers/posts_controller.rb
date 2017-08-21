class PostsController < ApplicationController

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    respond_to do |format|
      if @post.save
        format.html {redirect_to home_path, notice: "Post saved successfully"}
      else
        format.html {redirect_to home_path, alert: "Post not saved"}
      end
    end
  end

  private

  def post_params
    params.require(:post).permit(:content)
  end

end