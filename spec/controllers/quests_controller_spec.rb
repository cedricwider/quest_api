require 'rails_helper'

describe QuestsController, type: :controller do

  before :each do
    clan = Clan.new(name: 'rspec')
    clan.save!
    ruben = User.new(clan: clan, first_name: 'ruben', last_name: 'tester', hero_name: 'rspec', email: 'anyone@anywhere.com')
    ruben.save!
    AuthToken.new(value: 1, user: ruben, lifespan: 30).save!
  end

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
