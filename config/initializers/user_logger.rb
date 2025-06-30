ActiveSupport::Notifications.subscribe("user.created") do |name, start, finish, id, payload|
  user = payload[:user]
  Rails.logger.info("[>LOG<] -> Novo usuario criado: #{ user.email } em #{ start }")
end
