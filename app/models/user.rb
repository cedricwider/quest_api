class User < ApplicationRecord
  belongs_to :clan
  has_many :quests, dependent: :destroy
  has_one :auth_token, dependent: :destroy

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :hero_name, presence: true
  validates :email, presence: true
end
