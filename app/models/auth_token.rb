class AuthToken < ApplicationRecord
  belongs_to :user

  validates :user, presence: true
  validates :lifespan, presence: true

  after_initialize :ensure_lifespan_set
  after_initialize :ensure_value_set

  def ensure_lifespan_set
    self.lifespan ||= 3000
  end

  def ensure_value_set
    self.value ||= SecureRandom.uuid.gsub(/\-/,'')
  end

  def active?
    DateTime.now < self.updated_at + self.lifespan.seconds
  end

end
