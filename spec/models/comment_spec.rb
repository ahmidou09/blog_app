require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'Associations' do
    it { should belong_to(:post) }
    it { should belong_to(:user) }
  end

  describe 'Callbacks' do
    it 'updates post comments counter after save' do
      post = create(:post)
      comment = build(:comment, post:)

      expect { comment.save }.to change { post.reload.comments_counter }.by(1)
    end
  end
end
