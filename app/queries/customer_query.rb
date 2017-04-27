class CustomerQuery
  def initialize(customer_id)
    @query = SqlQuery.new(:customer, customer_id: customer_id)
  end

  def render
    @query.execute.map(&:symbolize_keys)
  end
end