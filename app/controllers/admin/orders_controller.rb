class Admin::OrdersController < Admin::BaseController 
  def index
    query = OrdersQuery.new().with_status(params[:status])
    .from_date(params[:from])
    .to_date(params[:to])
    .by_user(params[:user_id])

    @orders = query.paginate(params[:page])
  end

  def export_report
    ExportOrdersReportJob.perform_later(current_user.email)
    redirect_to admin_orders_path, notice: "Relatório será enviado para seu e-mail."
  end
end
