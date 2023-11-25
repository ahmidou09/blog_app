require 'swagger_helper'

describe 'Api::PostsController' do
  path '/api/users/{user_id}/posts' do
    parameter name: 'user_id', in: :path, type: :integer, required: true

    get 'Retrieves a list of posts for a user' do
      tags 'Posts'
      produces 'application/json'
      parameter name: :user_id, in: :path, type: :integer

      response '200', 'successful' do
        schema type: :array,
               items: {
                 type: :object,
                 properties: {
                   id: { type: :integer },
                   title: { type: :string },
                   text: { type: :string },
                   created_at: { type: :string, format: 'date-time' },
                   updated_at: { type: :string, format: 'date-time' }
                 },
                 required: ['id', 'title', 'text', 'created_at', 'updated_at']
               }

        run_test! do
        end
      end

      response '404', 'user not found' do
        run_test!
      end
    end
  end
end
