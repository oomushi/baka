require 'swagger_helper'
describe 'Token' do
  path '/api/token' do
    post 'New Token' do
      tags 'Authentication'
      consumes 'application/json'
      parameter name: :username, in: :body, schema: {type: :string }
      parameter name: :password, in: :body, schema: {type: :string }
      response '200', 'token created' do
        let(:token) { { username: 'Pippo', password: '' } }
        run_test!
      end
    end
  end
end
