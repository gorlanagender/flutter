module Storage
  class PostStore

    def build_post
      Post.new
    end

    def create_post(post:)
      post.save!
      post
    rescue ActiveRecord::RecordInvalid
      raise ActiveRecord::RecordInvalid.new(post)
    end

    def get_all_posts(user_id:)
      Post.where(user_id: user_id)
    end

    def get_top_users(user_id:)
      User.all.where.not(id: user_id).limit(5)
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

    def get_posts(user:)
      user_ids = user.active_relationship.map(&:followed_id)
      user_ids << user.id
      Post.where(user_id: user_ids)
    end
  end
end