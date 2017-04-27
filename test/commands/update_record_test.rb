require 'test_helper'

class UpdateRecordTest < ActiveSupport::TestCase
  test "success" do 
  	CreateCustomer.call("Dung", "01214115322")
  	customer = Customer.last
  	command = UpdateRecord.call(customer, { city: "Hai Phong"} )
  	assert command.result.city, "Hai Phong"
  end
end