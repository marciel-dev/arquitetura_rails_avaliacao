class Client::OrdersController < ApplicationController
  before_action :require_login!

  def index
    @orders = current_user.orders.includes(order_items: :product).order(created_at: :desc)
  end

  def show
    @order = Order.find(params[:id]).decorate
  end

  def new
    @order = current_user.orders.build
  end

  def create
    result = Orders::CreateService.new(user: current_user, params: params).call
  
    if result.success?
      redirect_to root_path, notice: "Pedido criado com sucesso."
    else
      @order = current_user.orders.build
      flash.now[:alert] = result.errors.to_sentence
      render :new, status: :unprocessable_entity
    end
  end


  private

  def require_login!
    redirect_to login_path unless current_user
  end
end
