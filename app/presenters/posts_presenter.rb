class PostsPresenter
  include Presenters::BasePresenter

  class Scalar < Presenters::ScalarPresenter
    def post_name
      @post_name ||= user.username
    end

    def avatar
      user.avatar_url
    end

    def display_time
      " - #{created_at.to_formatted_s(:short)}"
    end

    def users
      @users
    end

    def new_post
      @new_post
    end
  end

  class Enum < Presenters::EnumPresenter

  end
end