class Quest < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :clan, optional: false

  after_initialize :set_defaults
  validates :name, presence: true
  validates :description, presence: true
  validates :status, presence: true
  validates :clan, presence: true

  def set_defaults
    self.status ||= 'open'
  end
end
