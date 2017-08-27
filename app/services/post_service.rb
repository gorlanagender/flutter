module Services

  class PostService < BusinessService

    def build_post
      post_storage.build_post
    end

    def create_post(attrs:)
      post = build_from_attrs(attrs: attrs)
      post_storage.create_post(post: post)
    end

    def get_all_posts(user_id: user.id)
      post_storage.get_all_posts(user_id: user_id)
    end

    def get_top_users
      post_storage.get_top_users(user_id: user.id)
    end

    def follow_user(attrs:)
      post_storage.follow_user(attrs: attrs,
                               user: user)
    end

    def unfollow_user(attrs:)
      post_storage.unfollow_user(attrs: attrs, user: user)
    end

    def get_posts
      post_storage.get_posts(user: user)
    end

    private

    def build_from_attrs(attrs:)
      builder.from_attributes(attrs: attrs, user_id: user.id)
    end

    def build_follow_user_from_attrs(attrs:)
      builder.build_follow_user_from_attrs(attrs, user_id: user.id)
    end

    def builder
      @builder ||= Builders::PostBuilder.new
    end

  end

end