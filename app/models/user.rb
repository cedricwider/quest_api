class User < ApplicationRecord
  belongs_to :clan
  has_many :quests, dependent: :destroy
  has_one :auth_token, dependent: :destroy
end
