class UserDecorator < Draper::Decorator
  delegate_all

  def full_name
    "#{object.first_name} #{object.last_name}"
  end
  

  def created_at_formatted
    created_at.strftime("%d/%m/%Y %H:%M")
  end
end
