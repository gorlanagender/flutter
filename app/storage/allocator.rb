module Storage
  class Allocator
    def post_store
      Storage::PostStore.new
    end

    def user_store
      Storage::UserStore.new
    end

    def api_store
      Storage::ApiStore.new
    end
  end
end