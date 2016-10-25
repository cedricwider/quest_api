require 'rails_helper'

describe Quest, type: :model do

  it 'is in state open by default' do
    quest = described_class.new

    expect(quest.status).to eq 'open'
  end

  describe 'validations' do
    it 'is valid when all values are set' do
      quest = described_class.new(name: 'rspec_name', description: 'rspec_description')
      expect(quest.valid?).to be true
    end

    it 'must have a name' do
      quest = described_class.create(description: 'rspec_description')
      expect(quest.valid?).to be false
    end

    it 'must have a description' do
      quest = described_class.new(name: 'rspec_name')
      expect(quest.valid?).to be false
    end
  end

end
