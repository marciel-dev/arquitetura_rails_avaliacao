class HomeController < ApplicationController
  def index
    @q = Product.ransack(params[:q])
    @products = @q.result.order(:name).page(params[:page]).per(12)
  end
end
