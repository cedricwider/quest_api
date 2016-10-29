require 'rails_helper'

describe User, type: :model do

  let :valid_user_params do
    {
      first_name: 'Tony',
      last_name:  'Stark',
      hero_name:  'Iron Man',
      email:      'tony@starkcorporation.org',
      password:   'swordfish'
    }
  end

  it 'creates a valid auth token when user is created' do
    user = described_class.new(valid_user_params)
    expect(user.valid?).to be true

    user.save
    expect(user.auth_token).not_to be nil

    token = AuthToken.find_by(value: user.auth_token.value)
    expect(token).not_to be nil
  end

end
