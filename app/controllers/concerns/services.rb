# CLEAN ARCHITECTURE
#
# create a method here that will instantiate a service
# we can extend as needed
#

module Services
  extend ActiveSupport::Concern
  included do

    def post_service
      @post_service ||= Services::PostService.new(current_user)
    end

    def user_service
      @user_service ||= Services::UserService.new(current_user)
    end

    def api_service
      @api_service ||= Services::ApiService.new(current_user)
    end

  end
end