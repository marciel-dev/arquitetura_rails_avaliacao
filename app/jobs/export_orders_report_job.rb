class ExportOrdersReportJob < ApplicationJob
  queue_as :default

  def perform(email)
    file_data = Orders::XlsxReportService.generate
    AdminReportMailer.orders_report(email, file_data).deliver_now
  end
end
