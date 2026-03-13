class User < ApplicationRecord
  mount_uploader :avatar, AvatarUploader

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :recipes,       dependent: :destroy
  has_many :saved_recipes, dependent: :destroy
  has_many :saved,         through: :saved_recipes, source: :recipe

  has_many :active_follows,  class_name: "Follow", foreign_key: :follower_id, dependent: :destroy
  has_many :passive_follows, class_name: "Follow", foreign_key: :followed_id, dependent: :destroy
  has_many :following, through: :active_follows,  source: :followed
  has_many :followers, through: :passive_follows, source: :follower

  validates :username, presence: true, uniqueness: { case_sensitive: false }
end
