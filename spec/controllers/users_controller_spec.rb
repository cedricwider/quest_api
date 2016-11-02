require 'rails_helper'

describe UsersController, type: :controller do
  fixtures :all

  let :headers do
    {'HTTP_AUTHORIZATION' => ActionController::HttpAuthentication::Token.encode_credentials(1)}
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

  let :ruben do
    users(:ruben)
  end

  describe 'create' do

    it 'does not allow access to all users' do
      get :index
      expect(response.status).to eq 401
    end

    it 'finds users by email' do
      @request.headers.merge headers
      get :show, params: {id: 'ruben.tester@rspec.com'}
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

    it 'suppresses password in response' do
      post :create, body: valid_user.to_json, as: :json
      response_object = JSON.parse(response.body).symbolize_keys
      expect(response_object.has_key?(:password)).to be false
    end
  end

  describe 'read' do

    it 'allows to read users' do
      @request.headers.merge headers
      get :show, params: {id: ruben.email}, as: :json
      response_user = JSON.parse(response.body).symbolize_keys

      expect(response.status).to be 200
      expect(response_user).not_to be nil
      expect(response_user[:first_name]).to eq ruben.first_name
    end

    it 'suppresses password in response' do
      @request.headers.merge headers
      get :show, params: {id: ruben.email}, as: :json
      response_user = JSON.parse(response.body).symbolize_keys
      expect(response_user[:password]).to be nil
    end
  end

  describe 'update' do

    it 'updates fields' do
      @request.headers.merge headers
      patch :update, params: {id: ruben.email}, body: {first_name: 'updated!'}.to_json, as: :json

      db_user = User.find_by(email: ruben.email)
      expect(response.status).to be 200
      expect(db_user.first_name).to eq 'updated!'
    end

    it 'returns updated object' do
      @request.headers.merge headers
      patch :update, params: {id: ruben.email}, body: {first_name: 'updated!'}.to_json, as: :json

      response_user = JSON.parse(response.body).symbolize_keys
      expect(response_user[:first_name]).to eq 'updated!'
    end

    it 'suppresses password in response' do
      @request.headers.merge headers
      patch :update, params: {id: ruben.email}, body: {first_name: 'updated!'}.to_json, as: :json

      response_user = JSON.parse(response.body).symbolize_keys
      expect(response_user[:password]).to be nil
    end

  end

  describe 'delete' do
    it 'deletes users' do
      @request.headers.merge headers
      delete :destroy, params: {id: ruben.email}

      expect(response.status).to be 204
      expect(User.find_by(email: ruben.email)).to be nil
    end
  end

end
