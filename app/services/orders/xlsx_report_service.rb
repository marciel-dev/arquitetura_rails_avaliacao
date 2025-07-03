require 'axlsx'

module Orders
  class XlsxReportService
    def self.generate
      package = Axlsx::Package.new
      workbook = package.workbook

      workbook.add_worksheet(name: "Pedidos") do |sheet|
        sheet.add_row ["ID", "Cliente", "Status", "Total", "Data"]

        Order.includes(:user).find_each do |order|
          sheet.add_row [
            order.id,
            order.user.decorate.full_name,
            order.status,
            order.total.to_f,
            order.created_at.strftime("%d/%m/%Y %H:%M")
          ]
        end
      end

      # Retorna os bytes do arquivo gerado
      package.to_stream.read
    end
  end
end
