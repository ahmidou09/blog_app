class Post < ApplicationRecord
  belongs_to :user, class_name: 'User', foreign_key: 'author_id'
  has_many :likes
  has_many :comments

  after_save :updates_user_posts_counter

  def updates_user_posts_counter
    user.update(post_counter: user.posts.count)
  end

  def five_most_recent_comments
    comments.order(created_at: :desc).limit(5)
  end
end
