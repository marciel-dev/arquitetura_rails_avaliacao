class AdminReportMailer < ApplicationMailer
  def orders_report(email, file_data)
    attachments["relatorio_pedidos.xlsx"] = {
      mime_type: "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
      content: file_data
    }

    mail(
      to: email,
      subject: "Relatório de Pedidos",
      body: "Segue em anexo o relatório de pedidos em formato XLSX."
    )
  end
end
