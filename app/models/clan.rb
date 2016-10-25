class Clan < ApplicationRecord
  has_many :users, dependent: :nullify
end
