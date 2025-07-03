class OrderDecorator < Draper::Decorator
  delegate_all

  def display_status
    case object.status
    when "pending" then h.content_tag(:span, "Pendente", class: "badge bg-warning")
    when "completed" then h.content_tag(:span, "Concluído", class: "badge bg-success")
    else h.content_tag(:span, object.status.titleize, class: "badge bg-secondary")
    end
  end

  def total_formatted
    h.number_to_currency(object.total, unit: "R$", separator: ",", delimiter: ".")
  end

  def created_at_formatted
    object.created_at.strftime("%d/%m/%Y %H:%M")
  end
end
