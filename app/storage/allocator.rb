module Storage
  class Allocator
    def post_store
      Storage::PostStore.new
    end

    def user_store
      Storage::UserStore.new
    end
  end
end