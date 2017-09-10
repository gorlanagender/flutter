module Services
  class UserService < BusinessService
    def get_top_users
      user_storage.get_top_users(user: user)
    end

    def follow_user(attrs:)
      user_storage.follow_user(attrs: attrs,
                               user: user)
    end

    def unfollow_user(attrs:)
      user_storage.unfollow_user(attrs: attrs, user: user)
    end

    def get_profile(name:)
      user_storage.get_user(name: name)
    end
  end
end