require 'test_helper'

class CustomerQueryTest < ActiveSupport::TestCase
  test "success" do 
  	campaign_customers
  	query = CustomerQuery.new(Customer.first.id)
  	assert query.render.length, 2
  end
end
