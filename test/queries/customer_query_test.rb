require 'test_helper'

class CustomerQueryTest < ActiveSupport::TestCase
  test "success" do 
  	campaign_customers
  	customer = Customer.last
  	query = CustomerQuery.new(customer.id)
  	assert query.render.length, 2
  end
end
