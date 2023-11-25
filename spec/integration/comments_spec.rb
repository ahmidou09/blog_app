require 'swagger_helper'

describe 'Api::CommentsController' do
  path '/api/users/{user_id}/posts/{post_id}/comments' do
    parameter name: 'user_id', in: :path, type: :integer, required: true
    parameter name: 'post_id', in: :path, type: :integer, required: true

    get 'Retrieves a list of comments for a post' do
      tags 'Comments'
      produces 'application/json'
      parameter name: :user_id, in: :path, type: :integer
      parameter name: :post_id, in: :path, type: :integer

      response '200', 'successful' do
        schema type: :array,
               items: {
                 type: :object,
                 properties: {
                   id: { type: :integer },
                   text: { type: :string },
                   user: {
                     type: :object,
                     properties: {
                       id: { type: :integer },
                       name: { type: :string }
                     },
                     required: ['id', 'name']
                   },
                   created_at: { type: :string, format: 'date-time' },
                   updated_at: { type: :string, format: 'date-time' }
                 },
                 required: ['id', 'text', 'user', 'created_at', 'updated_at']
               }

        run_test! do
          # Additional verification if needed
        end
      end

      response '404', 'user or post not found' do
        run_test!
      end
    end

    post 'Creates a comment for a post' do
      tags 'Comments'
      consumes 'application/json'
      parameter name: :user_id, in: :path, type: :integer
      parameter name: :post_id, in: :path, type: :integer
      parameter name: :comment, in: :body, schema: {
        type: :object,
        properties: {
          text: { type: :string }
        },
        required: ['text']
      }

      response '201', 'comment created' do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 text: { type: :string },
                 user: {
                   type: :object,
                   properties: {
                     id: { type: :integer },
                     name: { type: :string }
                   },
                   required: ['id', 'name']
                 },
                 created_at: { type: :string, format: 'date-time' },
                 updated_at: { type: :string, format: 'date-time' }
               },
               required: ['id', 'text', 'user', 'created_at', 'updated_at']

        run_test! do
          # Additional verification if needed
        end
      end

      response '422', 'unprocessable entity' do
        schema type: :object,
               properties: {
                 errors: {
                   type: :object,
                   additionalProperties: {
                     type: :array,
                     items: {
                       type: :string
                     }
                   }
                 }
               },
               required: ['errors']

        run_test! do
          # Additional verification if needed
        end
      end
    end
  end
end
