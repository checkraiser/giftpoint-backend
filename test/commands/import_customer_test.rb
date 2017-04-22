require 'test_helper'

class ImportCustomerTest < ActiveSupport::TestCase
  test "success import" do 
  	cc = ImportCustomer.call(campaign, "customer 1", "01214115322")
  	assert CampaignCustomer.all, [cc]
  end
end