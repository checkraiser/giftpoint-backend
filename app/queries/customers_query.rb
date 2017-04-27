class CustomersQuery
  def initialize
    @query = SqlQuery.new(:all_customers)
  end

  def render
    @query.execute.map(&:symbolize_keys)
  end
end