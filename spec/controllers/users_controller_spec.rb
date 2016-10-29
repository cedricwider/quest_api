require 'rails_helper'

describe UsersController, type: :controller do
  fixtures :all

  let :headers do
    { 'HTTP_AUTHORIZATION' => ActionController::HttpAuthentication::Token.encode_credentials(1) }
  end

  let :valid_user do
    {
      first_name: 'David',
      last_name: 'Bruderer',
      hero_name: 'Rockstar',
      email: 'david.bruderer@rockstar.com',
      password: 'pumpkin'
    }
  end

  it 'does not allow access to all users' do
    get :index
    expect(response.status).to eq 401
  end

  it 'finds users by email' do
    @request.headers.merge headers
    get :show, params: { id: 'ruben.tester@rspec.com' }
    expect(response.status).to eq 200
  end

  it 'saves users' do
    post :create, body: valid_user.to_json, as: :json

    expect(response.status).to eq 201
    expect(User.find_by(email: valid_user[:email])).not_to be nil
    expect(response.headers['HTTP_AUTHORIZATION']).not_to be nil
  end

  it 'encrypts passwords when creating a user' do
    post :create, body: valid_user.to_json, as: :json

    db_user = User.find_by(email: valid_user[:email])
    expect(db_user).not_to be nil
    expect(db_user.password).not_to eq valid_user[:password]
  end
end
