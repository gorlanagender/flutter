module Storage
  class UserStore
    def get_top_users(user:)
      user_ids = user.active_relationship.map(&:followed_id)
      user_ids << user.id
      User.all.where.not(id: user_ids).limit(5)
    end

    def follow_user(attrs:, user:)
      relationship = user.active_relationship.build
      relationship.attributes = attrs
      relationship.save!
      relationship
    end

    def unfollow_user(attrs:, user:)
      user.active_relationship
          .where(followed_id: attrs[:followed_id])
          .order(created_at: :asc)
          .last
          .destroy
    end

    def get_user(name:)
      user = User.find_by_username(name)
      raise Exceptions::UserExceptions::RecordNotFound unless user.present?
      user
    end
  end
end