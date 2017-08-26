module Storage
  class Allocator
    def post_store
      Storage::PostStore.new
    end
  end
end