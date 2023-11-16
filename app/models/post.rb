class Post < ApplicationRecord
  after_save :updates_user_post_counter
  belongs_to :user, class_name: 'User', foreign_key: 'author_id'
  has_many :likes
  has_many :comments

  validates :title, presence: true, length: { maximum: 250 }
  validates :comments_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :likes_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def five_most_recent_comments
    comments.order(created_at: :desc).limit(5)
  end

  private

  def updates_user_post_counter
    user.update(post_counter: user.posts.count)
  end
end
