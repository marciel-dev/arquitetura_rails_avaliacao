class OrderMailer < ApplicationMailer
  def confirmation
    @order = params[:order]
    mail(to: @order.user.email, subject: "Confirmação do seu pedido ##{@order.id}")
  end
end
