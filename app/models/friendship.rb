class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: "User"

  def between(first, second)
    where("user_id = ? AND friend_id = ?", )
  end
end
