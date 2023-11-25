require 'swagger_helper'

describe 'Api::SessionsController' do
  path '/api/users/sign_in' do
    post 'Signs in a user' do
      tags 'Sessions'
      consumes 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string },
          password: { type: :string }
        },
        required: ['email', 'password']
      }

      response '200', 'successful' do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 email: { type: :string },
                 authentication_token: { type: :string },
                 created_at: { type: :string, format: 'date-time' },
                 updated_at: { type: :string, format: 'date-time' }
               },
               required: ['id', 'email', 'authentication_token', 'created_at', 'updated_at']

        run_test! do
          # Additional verification if needed
        end
      end

      response '401', 'unauthorized' do
        schema type: :object,
               properties: {
                 error: { type: :string }
               },
               required: ['error']

        run_test! do
          # Additional verification if needed
        end
      end
    end
  end
end
