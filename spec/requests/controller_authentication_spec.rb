require 'rails_helper'

describe 'Controller Authentication', type: :request do

  before :each do
    clan = Clan.new(name: 'rspec')
    clan.save!
    ruben = User.new(clan: clan, first_name: 'ruben', last_name: 'tester', hero_name: 'rspec', email: 'anyone@anywhere.com')
    ruben.save!
    AuthToken.new(value: 1, user: ruben, lifespan: 30).save!
  end

  it 'returns 401 if not authenticated' do
    get clans_path
    expect(response.status).to eq 401
  end

  it 'returns 200 if correctly authenticated' do
    get clans_path, headers: { 'HTTP_AUTHORIZATION' => ActionController::HttpAuthentication::Token.encode_credentials(1) }
    expect(response.status).to eq 200
  end
end
