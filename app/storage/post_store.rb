module Storage
  class PostStore

    def build_post
      Post.new
    end

    def create_post(post:)
      post.save!
      post
      # rescue ActiveRecord::RecordInvalid
      #   raise ActiveRecord::RecordInvalid.new(post)
    end

    def get_all_posts(user_id:)
      Post.where(user_id: user_id)
    end
  end
end