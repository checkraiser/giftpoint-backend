require 'test_helper'

class CustomersQueryTest < ActiveSupport::TestCase
  test "correct" do 
  	campaign_customers
  	query = CustomersQuery.new
  	assert query.render.length, 2
  end
end