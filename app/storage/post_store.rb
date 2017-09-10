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

    def get_posts(user:)
      user_ids = user.active_relationship.map(&:followed_id)
      user_ids << user.id
      Post.where(user_id: user_ids)
    end
  end
end