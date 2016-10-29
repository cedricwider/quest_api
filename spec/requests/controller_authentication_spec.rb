require 'rails_helper'

describe 'Controller Authentication', type: :request do

  fixtures :all

  let :headers do
    { 'HTTP_AUTHORIZATION' => ActionController::HttpAuthentication::Token.encode_credentials(token_id) }
  end

  context 'happy path' do
    let(:token_id) { 1 }

    it 'returns 200 if correctly authenticated' do
      get clans_path, headers: headers
      expect(response.status).to eq 200
    end

    it 'adds the token to the response header' do
      get clans_path, headers: headers
      expect(response.headers['HTTP_AUTHORIZATION']).to eq '1'
    end
  end

  context 'exceptions' do

    let(:token_id) { 2 }

    it 'returns 401 if token is expired' do
      get clans_path, headers: headers
      expect(response.status).to eq 401
    end

    it 'returns 401 if not authenticated' do
      get clans_path
      expect(response.status).to eq 401
    end
  end
end
