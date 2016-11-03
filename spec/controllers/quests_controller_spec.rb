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

  before :each do
    headers = { 'HTTP_AUTHORIZATION' => ActionController::HttpAuthentication::Token.encode_credentials(1) }
    @request.headers.merge headers
  end

  describe 'create' do

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

  describe 'read' do

    it 'shows a single quest by its id' do
      get :show, params: { id: 1 }
      response_quest = JSON.parse(response.body)

      expect(response.status).to eq 200
      expect(response_quest['id']).to eq 1
    end

    it 'shows all the quests inside the same clan as the user' do
      get :index
      response_quests = JSON.parse(response.body)

      expect(response_quests).not_to be nil
      clan_ids = response_quests.collect { |quest| quest['clan_id'] }.uniq
      expect(clan_ids.size).to eq 1
    end
  end

  describe 'update' do

    it 'updates quests' do
      put :update, params: { id: 1 }, body: { name: 'updated!' }.to_json, as: :json

      expect(response.status).to eq 200
      expect(Quest.find(1).name).to eq 'updated!'
    end

  end

  describe 'delete' do
    it 'deletes quests' do
      delete :destroy, params: { id: 1 }

      expect(response.status).to eq 204
      expect { Quest.find(1) }.to raise_error ActiveRecord::RecordNotFound
    end
  end

end
