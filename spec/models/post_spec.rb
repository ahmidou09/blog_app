require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'Validations' do
    it { should validate_presence_of(:title) }
    it { should validate_length_of(:title).is_at_most(250) }
    it { should validate_numericality_of(:comments_counter).only_integer.is_greater_than_or_equal_to(0) }
    it { should validate_numericality_of(:likes_counter).only_integer.is_greater_than_or_equal_to(0) }
  end

  describe 'Associations' do
    it { should belong_to(:user).with_foreign_key('author_id') }
    it { should have_many(:comments) }
    it { should have_many(:likes) }
  end

  describe '#five_most_recent_comments' do
    it 'returns the five most recent comments for a post' do
      post = create(:post)
      create_list(:comment, 5, post:, created_at: 4.days.ago)
      recent_comments = create_list(:comment, 5, post:)

      expect(post.five_most_recent_comments).to eq(recent_comments.reverse)
    end
  end

  describe 'Callbacks' do
    it 'updates user posts counter after save' do
      user = create(:user)
      post = build(:post, user:)

      expect { post.save }.to change { user.reload.post_counter }.by(1)
    end
  end
end
