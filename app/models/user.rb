class User < ApplicationRecord
  mount_uploader :avatar, AvatarUploader
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :posts, dependent: :destroy
  has_many :active_relationship, class_name: 'Relationship', foreign_key: 'follower_id', dependent: :destroy
  has_many :passive_relationship, class_name: 'Relationship', foreign_key: 'followed_id'

  has_many :following, through: :active_relationship, source: :followed
  has_many :followers, through: :passive_relationship, source: :follower

  validates_integrity_of  :avatar
  validates_processing_of :avatar
  validates :username, uniqueness: true

  def following?(other)
    following.include?(other)
  end
end
