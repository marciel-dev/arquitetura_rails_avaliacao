class User < ApplicationRecord
  include SoftDeletable

  has_many :orders, dependent: :destroy
  has_secure_password

  validates :name, :email, presence: true
  validates :email, uniqueness: true

  scope :by_email, ->(email) { where(email: email) if email.present? }
end
