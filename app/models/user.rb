class User < ApplicationRecord
  belongs_to :clan
  has_many :quests, dependent: :destroy
end
