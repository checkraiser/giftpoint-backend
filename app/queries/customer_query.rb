class CustomerQuery < ApplicationQuery
  def initialize(customer_id, date1 = nil, date2 = nil)
    @query = SqlQuery.new(:customer, customer_id: customer_id, date1: date1, date2: date2)
  end
end
