require 'test_helper'

class CustomerTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "create customer" do 
  	customer = CreateCustomer.call("customer 1", "01214115322", "city", "address")
  	assert Customer.all, [customer]
  end
end
