class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user

  after_create :increment_comments_counter
  after_destroy :decrement_comments_counter

  private

  def increment_comments_counter
    post.increment!(:comments_counter)
  end

  def decrement_comments_counter
    post.decrement!(:comments_counter)
  end
end
