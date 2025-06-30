class Order < ApplicationRecord
  include SoftDeletable

  belongs_to :user

  validates :status, :total, presence: true

  scope :pending, -> { where(status: 'pending') }
  scope :completed, -> { where(status: 'completed') }
  scope :by_user, ->(user_id) { where(user_id: user_id) if user_id.present? }
end
