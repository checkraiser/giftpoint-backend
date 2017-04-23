require 'test_helper'

class BatchFileSetSmsCustomersTest < ActiveSupport::TestCase
  test "success" do 
  	BatchFileSetSmsCustomers.call(approved_campaign_customers, customers_sms_file)
  	assert CampaignCustomer.all, approved_campaign_customers
  end
end