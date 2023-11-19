require 'rails_helper'

RSpec.describe 'Users', type: :request do
  let(:user) { User.create(name: 'Mehdi', post_counter: 0) }

  describe 'GET #index' do
    it 'response status was correct' do
      get users_path
      expect(response).to have_http_status(:success)
    end

    it 'correct template was rendered' do
      get users_path
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #show' do
    it 'response status was correct' do
      get user_path(user)
      expect(response).to have_http_status(:success)
    end

    it 'correct template was rendered' do
      get user_path(user)
      expect(response).to render_template(:show)
    end
  end
end
