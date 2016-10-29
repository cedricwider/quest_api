require 'rails_helper'

describe AuthToken, type: :model do

   describe 'expiration' do
    it 'knows when it is expired' do
      auth_token = described_class.new(lifespan: -1, created_at: DateTime.now)
      expect(auth_token.active?).to be false
    end

    it 'knows when it is active' do
      auth_token = described_class.new(lifespan: 1, created_at: DateTime.now)
      expect(auth_token.active?).to be true
    end
   end
end
