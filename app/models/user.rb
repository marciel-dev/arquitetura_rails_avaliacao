class User < ApplicationRecord
  include SoftDeletable

  has_many :orders, dependent: :destroy
  has_secure_password

  validates :first_name, :last_name, :email, presence: true
  validates :email, uniqueness: true

  scope :by_email, ->(email) { where(email: email) if email.present? }

  enum role: { client: "client", admin: "admin" }

  def self.ransackable_attributes(auth_object = nil)
    %w[first_name last_name email created_at role status]
  end
  
end
