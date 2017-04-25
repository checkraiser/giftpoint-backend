require 'test_helper'

class CampaignCustomerQueryTest < ActiveSupport::TestCase
  test "by_phones" do 
	query = CampaignCustomerQuery.new(campaign_customers).by_phones(["01214115322"])
	assert query, [Customer.first]
  end

  test "by phone and code" do 
	BatchFileSetSmsCustomers.call(approved_campaign_customers, customers_sms_file)
	campaign_customer = CampaignCustomerQuery.new(campaign_customers).by_phones(["01214115322"])[0]
	query = CampaignCustomerQuery.new(campaign_customers).by_phone_and_code("01214115322", campaign_customer.code)
	assert query, campaign_customer
  end
end