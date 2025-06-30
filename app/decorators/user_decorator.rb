class UserDecorator < Draper::Decorator
  delegate_all

  def display_status
    case object.status
    when 'pending'
      "<span class='badge bg-warning'>Pendente</span>".html_safe
    when 'completed'
      "<span class='badge bg-success'>Concluído</span>".html_safe
    else
      "<span class='badge bg-secondary'>#{object.status}</span>".html_safe
    end
  end

  def total_currency
    h.number_to_currency(object.total, unit: 'R$', separator: ',', delimiter: '.')
  end
end
