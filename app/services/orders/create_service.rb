module Orders
  class CreateService
    def initialize(user:, params:)
      @user = user
      @params = params
    end

    def call
      build_order

      if @order.order_items.empty?
        return ResultService.failure(errors: ["O pedido deve conter pelo menos um produto."], order: @order)
      end

      ActiveRecord::Base.transaction do
        calculate_total
        @order.save!
        ActiveSupport::Notifications.instrument("order.created", order: @order)
      end

      ResultService.success(order: @order)
    rescue ActiveRecord::RecordInvalid => e
      ResultService.failure(errors: @order.errors.full_messages, order: @order)
    end

    private

    def build_order
      @order = @user.orders.build(order_attributes)
    
      order_items_attributes.each do |item|
        product = Product.find(item[:product_id])
        next if item[:quantity].to_i.zero?
        quantity = item[:quantity].to_i < 0 ? item[:quantity].to_i * -1 : item[:quantity].to_i
        @order.order_items.build(
          product: product,
          quantity: quantity,
          price: product.price
        )
      end
    end

    def order_attributes
      @params.require(:order).permit(:status)
    end

    def order_items_attributes
      permitted = @params.require(:order).permit(order_items_attributes: [:product_id, :quantity])
      (permitted[:order_items_attributes] || {}).values
    end

    def calculate_total
      @order.total = @order.order_items.sum do |item|
        item.price.to_f * item.quantity.to_i
      end
    end
  end
end