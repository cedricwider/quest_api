require 'rails_helper'

describe QuestsController, type: :controller do
  fixtures :all

  let :valid_quest_json do
    {
      name:        'rspec_quest',
      description: 'quest_description'
    }.to_json
  end

  let :headers do
    { 'HTTP_AUTHORIZATION' => ActionController::HttpAuthentication::Token.encode_credentials(1) }
  end

  describe 'Create' do

    it 'creates a quest with valid parameters' do
      @request.headers.merge headers
      post :create, body: valid_quest_json, format: :json

      expect(response.status).to be 201
      expect(Quest.find_by name: 'rspec_quest').not_to be nil
    end

  end

end
