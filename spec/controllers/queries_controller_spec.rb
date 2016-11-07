require 'rails_helper'

describe QueriesController, type: :controller do

  fixtures :all

  before :each do
    headers = {
      'HTTP_AUTHORIZATION' => ActionController::HttpAuthentication::Token.encode_credentials(1),
      'Content-Type' => 'application/json'
    }
    @request.headers.merge headers
  end

  let :query_string do
    '{ user { first_name last_name } }'
  end

  it 'can query by params' do
    post :create, params: { query: query_string }, as: :json
    data = JSON.parse(response.body)['data']

    expect(response.status).to eq 200
    expect(data).not_to be nil
    expect(data['user']).not_to be nil
  end

  it 'can query by body' do
    post :create, body: { query: query_string }.to_json, as: :json
    data = JSON.parse(response.body)['data']

    expect(response.status).to eq 200
    expect(data).not_to be nil
    expect(data['user']).not_to be nil
  end
end
