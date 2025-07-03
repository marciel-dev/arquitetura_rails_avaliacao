ActiveSupport::Notifications.subscribe("order.created") do |name, start, finish, id, payload|
  order = payload[:order]
  Rails.logger.info("[>LOG<] -> Novo pedido criado: #{ order.id } em #{ start }")

  OrderConfirmationJob.perform_later(order.id)
end
