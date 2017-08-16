class Post < ApplicationRecord

  CONTENT_MAX_LENGTH = 140

  belongs_to :user

  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: CONTENT_MAX_LENGTH }

  default_scope -> { order(created_at: :desc) }
end
