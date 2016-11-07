require 'rails_helper'

describe UserSchema do

  fixtures :all

  let(:user) { users(:ruben) }
  let(:clan) { user.clan }

  it 'finds users by id' do
    query_string = '{ user(user_id: 1) { first_name last_name clan {name} quests(status: "open") { name description status } } }'
    result = UserSchema.execute(query_string)

    expect(result).not_to be nil
    expect(result['errors']).to be nil
    expect(result['data']).not_to be nil

    result_user = result.dig('data', 'user')
    expect(result_user['first_name']).to eq user.first_name
    expect(result_user['last_name']).to eq user.last_name

    result_clan = result.dig('data', 'user', 'clan')
    expect(result_clan['name']).to eq clan.name

    result_quests = result.dig('data', 'user', 'quests')
    expect(result_quests.size).to eq 1
  end
end
