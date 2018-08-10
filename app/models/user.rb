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

  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :post

  def name
    "#{first_name} #{last_name}"
  end

  # Returns all friends
  def friends
    active_friends | received_friends
  end

  # Returns invites
  def pending
    pending_friends | requested_friendships
  end

  # Creates a new like row with post_id and user_id
  def like!(post)
    self.likes.create!(post_id: post.id)
  end

  # Destroys a like with matching post_id and user_id
  def dislike!(post)
    like = self.likes.find_by(post_id: post.id)
    like.destroy!
  end

  # Returns true if post is liked by user
  def like?(post)
    self.likes.find_by(post_id: post.id) ? true : false
  end

end
