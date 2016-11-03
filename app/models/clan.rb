class Clan < ApplicationRecord
  has_many :users, dependent: :nullify
  has_many :quests, dependent: :destroy

  validates :name, presence: true

  def self.global_clan
    Clan.find_by(name: 'Global Clan')
  end
end
