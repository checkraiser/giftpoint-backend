require 'test_helper'

class CampaignCustomerQueryTest < ActiveSupport::TestCase
	test "correct" do 
	   query = CampaignCustomerQuery.new(campaign_customers).by_phones(["01214115322"])
	   assert query, [Customer.first]
	end
end