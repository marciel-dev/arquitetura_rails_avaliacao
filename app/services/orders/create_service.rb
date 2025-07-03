module Orders
  class CreateService
    def initialize(user:, params:)
      @user = user
      @params = params
    end

    def call
      build_order

      ActiveRecord::Base.transaction do
        calculate_total
        @order.save!
        ActiveSupport::Notifications.instrument("order.created", order: @order)
      end

      ResultService.success(order: @order)
    rescue ActiveRecord::RecordInvalid => e
      ResultService.failure(success: false, errors: @order.errors.full_messages)
    end

    private

    def build_order
      @order = @user.orders.build(order_attributes)
    
      order_items_attributes.each do |item|
        product = Product.find(item[:product_id])
        @order.order_items.build(
          product: product,
          quantity: item[:quantity],
          price: product.price
        )
      end
    end

    def order_attributes
      @params.require(:order).permit(:status)
    end

    def order_items_attributes
      @params.require(:order).permit(order_items_attributes: [:product_id, :quantity])[:order_items_attributes].values
    end

    def calculate_total
      @order.total = @order.order_items.sum do |item|
        item.price.to_f * item.quantity.to_i
      end
    end
  end
end