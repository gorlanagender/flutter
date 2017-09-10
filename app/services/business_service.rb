module Services
  class BusinessService
    attr_reader :user

    def initialize(user = nil)
      @user = user
    end

    def engine
      @engine ||= ::Storage::Allocator.new
    end

    def post_storage
      @post_storage ||= engine.post_store
    end

    def user_storage
      @user_storage ||= engine.user_store
    end

    def api_storage
      @api_storage ||= engine.api_store
    end
  end
end