require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  let(:user) { User.create(name: 'Mehdi', post_counter: 0) }
  let(:post) { Post.create(title: 'Test post', author_id: user.id, comments_counter: 0, likes_counter: 0) }

  describe 'GET #index' do
    before do
      get user_posts_path(user)
    end

    it 'response status was correct' do
      expect(response).to have_http_status(:success)
    end

    it 'correct template was rendered' do
      expect(response).to render_template(:index)
    end

    it 'response body includes correct placeholder text' do
      expect(response.body).to include('posts')
    end
  end

  describe 'GET #show' do
    before do
      get user_post_path(user, post)
    end

    it 'response status was correct' do
      expect(response).to have_http_status(:success)
    end

    it 'correct template was rendered' do
      expect(response).to render_template(:show)
    end
  end
end
