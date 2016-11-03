require 'rails_helper'

describe QuestsController, type: :controller do
  fixtures :all

  let :valid_quest_json do
    {
      name:        'rspec_quest',
      description: 'quest_description'
    }.to_json
  end

  let(:current_user) { AuthToken.find(1).user }

  let :headers do
    { 'HTTP_AUTHORIZATION' => ActionController::HttpAuthentication::Token.encode_credentials(1) }
  end

  before :each do
    @request.headers.merge headers
  end

  describe 'Create' do

    it 'creates a quest with valid parameters' do
      post :create, body: valid_quest_json, as: :json

      expect(response.status).to be 201
      expect(Quest.find_by name: 'rspec_quest').not_to be nil
    end

    it 'assigns newly created quests to the clan of the current user' do
      post :create, body: valid_quest_json, as: :json
      db_quest = Quest.find_by(name: 'rspec_quest')

      expect(db_quest.clan.id).to eq current_user.clan.id
    end

  end

end
