require 'test_helper'

class CleanCampaignCustomersTest < ActiveSupport::TestCase
	test "success" do 
		CleanCampaignCustomers.call campaign_customers
		assert CampaignCustomer.all, []
	end
end