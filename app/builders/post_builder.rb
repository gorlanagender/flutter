module Builders
  class PostBuilder

    def from_attributes(attrs:, user_id:)
      Post.tap {|post|
        post.attributes = attrs
        post.create_user_id = user_id
      }
    end

  end
end