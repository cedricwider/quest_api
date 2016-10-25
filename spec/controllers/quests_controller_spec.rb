require 'rails_helper'

describe QuestsController, type: :controller do

  let(:valid_quest_json) do
    {
      name:        'rspec_quest',
      description: 'quest_description'
    }.to_json
  end

  describe 'Create' do

    it 'creates a quest with valid parameters' do
      post :create, body: valid_quest_json, format: :json

      expect(Quest.find_by name: 'rspec_quest').not_to be nil
    end

  end

end
