class Order < ApplicationRecord
  include SoftDeletable

  belongs_to :user
  has_many :order_items, dependent: :destroy
  has_many :products, through: :order_items
  
  validates :status, :total, presence: true
  
  enum status: {
    pendente: "pendente",
    pago: "pago",
    cancelado: "cancelado",
    entregue: "entregue"
  }, _default: "pendente"

  accepts_nested_attributes_for :order_items, allow_destroy: true
  
  scope :pending, -> { where(status: 'pending') }
  scope :completed, -> { where(status: 'completed') }
  scope :by_user, ->(user_id) { where(user_id: user_id) if user_id.present? }
end
