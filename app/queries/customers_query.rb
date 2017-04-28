class CustomersQuery < ApplicationQuery
  def initialize
    @query = SqlQuery.new(:all_customers)
  end
end
