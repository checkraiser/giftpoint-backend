require 'test_helper'

class GenerateCustomerCodeTest < ActiveSupport::TestCase
  test "generate codes" do 
  	code = GenerateCustomerCode.call campaign_customer 
  	assert code.result.code, CampaignCustomer.last.code
  end	

  test "batch generate" do
  	records = [{name: "n1", phone: "p1", gen_count: 1},
  			   {name: "n2", phone: "p2", gen_count: 1},
  			   {name: "n3", phone: "p3", gen_count: 2}]
  	BatchImportCustomers.call(campaign, records)
  	codes = BatchGenerateCustomerCodes.call(campaign.campaign_customers).result
  	assert CampaignCustomer.count, 4
  	assert CampaignCustomer.pluck(:code), codes
  end
end
