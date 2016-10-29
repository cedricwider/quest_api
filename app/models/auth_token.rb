class AuthToken < ApplicationRecord
  belongs_to :user

  validates :user, presence: true
  validates :lifespan, presence: true

  def active?
    DateTime.now < self.created_at + self.lifespan.seconds
  end

end
