class OrderConfirmationJob < ApplicationJob
  queue_as :default

  def perform(order_id)
    order = Order.find(order_id)
    OrderMailer.with(order: order).confirmation.deliver_now
  end
end
