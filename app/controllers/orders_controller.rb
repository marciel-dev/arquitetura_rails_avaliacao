class OrdersController < ApplicationController
  def index
    @orders = Order.includes(:user).decorate
  end

  def show
    @order = Order.find(params[:id]).decorate
  end

  def new
    @order = Order.new
  end

  def create
    result = Orders::CreateService.new(order_params).call

    if result.success?
      redirect_to users_path, notice: 'Pedido criado com sucesso.'
    else
      @order = Order.new(order_paramsparams)
      flash.now[:alert] = result.errors.join(', ')
      render :new, status: :unprocessable_entity
    end
  end

  private

  def order_params
    params.require(:order).permit(:user_id, :status, :total)
  end
end
