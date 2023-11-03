require 'rails_helper'

RSpec.describe Like, type: :model do
  describe 'Associations' do
    it { should belong_to(:post) }
    it { should belong_to(:user) }
  end

  describe 'Callbacks' do
    it 'updates post likes counter after save' do
      post = create(:post)
      like = build(:like, post:)

      expect { like.save }.to change { post.reload.likes_counter }.by(1)
    end
  end
end
