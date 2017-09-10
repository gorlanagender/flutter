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
  end

  class Enum < Presenters::EnumPresenter

  end
end