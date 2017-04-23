require 'test_helper'

class ApproveCampaignCustomersTest < ActiveSupport::TestCase
  test "success" do 
  	BatchGenerateCustomerCodes.call campaign_customers
  	ApproveCampaignCustomers.call campaign_customers
  	assert campaign_customers.approved, campaign_customers
  end
end