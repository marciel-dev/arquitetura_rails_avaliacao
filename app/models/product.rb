class Product < ApplicationRecord
  has_many :order_items
  has_many :orders, through: :order_items

  def self.ransackable_attributes(auth_object = nil)
    %w[name price]
  end
end
