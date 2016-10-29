class User < ApplicationRecord
  belongs_to :clan
  has_many :quests, dependent: :destroy
  has_one :auth_token, dependent: :destroy

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :hero_name, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true

  after_initialize :ensure_clan_set
  before_create :ensure_auth_token_set

  def ensure_clan_set
    self.clan ||= Clan.global_clan
  end

  def ensure_auth_token_set
    return if self.auth_token.present?
    auth_token      = AuthToken.new()
    auth_token.user = self
  end
end
