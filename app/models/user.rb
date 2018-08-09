class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :posts, foreign_key: 'author_id', dependent: :destroy
  has_many :comments, foreign_key: 'author_id'
  has_many :comments, foreign_key: 'author_id'
  has_many :friendships
  has_many :received_friendships, class_name: 'Friendship', foreign_key: 'friend_id'

  has_many :active_friends, -> { where(friendships: { confirmed: true }) }, through: :friendships, source: :friend
  has_many :received_friends, -> { where(friendships: { confirmed: true }) }, through: :received_friendships, source: :user
  has_many :pending_friends, -> { where(friendships: { confirmed: false }) }, through: :friendships, source: :friend
  has_many :requested_friendships, -> { where(friendships: { confirmed: false }) }, through: :received_friendships, source: :user

  # Returns all friends

  def friends
    active_friends | received_friends
  end

  # Returns invites

  def pending
    pending_friends | requested_friendships
  end

end
