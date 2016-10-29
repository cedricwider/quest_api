require 'rails_helper'

describe LoginsController, type: :controller do

  fixtures :all

  let :valid_login_params do
    {
      email:    users(:ruben).email,
      password: 'rspec'
    }
  end

  it 'allows login with valid credentials' do
    post :create, body: valid_login_params.to_json, as: :json
    expect(response.status).to be 200
  end

  it 'sets authorization token after login' do
    post :create, body: valid_login_params.to_json, as: :json
    expect(response.headers['HTTP_AUTHORIZATION']).not_to be nil
  end

  describe 'invalid login credentials' do

    it 'disallows login with invalid credentials' do
      post :create, body: { email: users(:ruben).email, password: 'wrong_password'}.to_json, as: :json
      expect(response.status).to eq 401
    end
  end

end
