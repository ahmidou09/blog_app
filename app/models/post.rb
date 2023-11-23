class Post < ApplicationRecord
  belongs_to :user, class_name: 'User', foreign_key: 'author_id'
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :title, presence: true, length: { maximum: 250 }
  validates :comments_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :likes_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  after_save :update_user_post_counter
  after_destroy :decrement_user_post_counter

  def five_most_recent_comments
    comments.order(created_at: :desc).limit(5)
  end

  private

  def update_user_post_counter
    user.increment!(:post_counter)
  end

  def decrement_user_post_counter
    user.decrement!(:post_counter)
  end
end
