require 'rails_helper'

describe ClansController, type: :controller do
  fixtures :all

  let :headers do
    {'HTTP_AUTHORIZATION' => ActionController::HttpAuthentication::Token.encode_credentials(1)}
  end

  let :valid_clan do
    {name: 'test clan'}
  end

  let :user do
    auth_token = AuthToken.find(1)
    auth_token.user
  end

  let(:family_clan) { clans(:family) }

  before :each do
    @request.headers.merge headers
  end

  it 'creates a clan' do
    post :create, body: valid_clan.to_json, as: :json
    response_clan = JSON.parse(response.body).symbolize_keys

    expect(response.status).to eq 201
    expect(response_clan).not_to be nil
    expect(response_clan[:name]).to eq 'test clan'
  end

  it 'can read a single clan' do
    clan_id = family_clan.id
    get :show, params: {id: clan_id}
    response_clan = JSON.parse(response.body).symbolize_keys

    expect(response_clan[:name]).to eq family_clan.name
  end

  it 'can read multiple clans' do
    get :index
    response_clans = JSON.parse(response.body)

    response_clans.map do |clan|
      expect(clan['id']).not_to be nil
      expect(clan['name']).not_to be nil
    end
  end

  it 'updates a clan' do
    clan_id = family_clan.id
    patch :update, params: {id: clan_id}, body: {name: 'updated!'}.to_json, as: :json

    expect(response.status).to eq 200
    expect(Clan.find(clan_id).name).to eq 'updated!'
  end

  it 'deletes a clan' do
    clan_id = family_clan.id
    delete :destroy, params: {id: clan_id}

    expect(response.status).to be 204
    expect { Clan.find(clan_id) }.to raise_error ActiveRecord::RecordNotFound
  end

end
