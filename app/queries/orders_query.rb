class OrdersQuery
  def initialize(relation = Order.all)
    @relation = relation
  end

  def with_status(status)
    @relation = @relation.where(status: status) if status.present?
    self
  end

  def from_date(date)
    @relation = @relation.where("created_at >= ?", date.to_date.beginning_of_day) if date.present?
    self
  end

  def to_date(date)
    @relation = @relation.where("created_at <= ?", date.to_date.end_of_day) if date.present?
    self
  end

  def by_user(user_id)
    @relation = @relation.where(user_id: user_id) if user_id.present?
    self
  end

  def paginate(page)
    @relation.page(page).per(20)
  end
end
