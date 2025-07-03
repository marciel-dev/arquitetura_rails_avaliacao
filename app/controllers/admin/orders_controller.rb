class Admin::OrdersController < Admin::BaseController 
  def index
    query = OrdersQuery.new().with_status(params[:status])
    .from_date(params[:from])
    .to_date(params[:to])
    .by_user(params[:user_id])

    @orders = query.paginate(params[:page])
  end
end
