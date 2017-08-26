module Services
  class BusinessService
    attr_reader :user

    def initialize(user)
      @user = user
    end

    def engine
      @engine ||= ::Storage::Allocator.new
    end

    def post_storage
      @post_storage ||= engine.post_store
    end
  end
end