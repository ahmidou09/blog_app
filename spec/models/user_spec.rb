require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it { should validate_presence_of(:name) }
    it { should validate_numericality_of(:posts_counter).only_integer.is_greater_than_or_equal_to(0) }
  end

  describe 'Associations' do
    it { should have_many(:posts).with_foreign_key('author_id') }
    it { should have_many(:comments) }
    it { should have_many(:likes) }
  end

  describe '#three_most_recent_posts' do
    it 'returns the three most recent posts for a user' do
      user = create(:user)
      create(:post, user:, created_at: 4.days.ago)
      recent_posts = create_list(:post, 3, user:)

      expect(user.three_most_recent_posts).to eq(recent_posts.reverse)
    end
  end
end
