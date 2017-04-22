require 'test_helper'

class SetSmsStatusTest < ActiveSupport::TestCase
  test "success set status" do   	
  	sms = SetSmsStatus.call(campaign_customer).result
  	assert sms.sms_status, true
  end

  test "batch set" do 
  	records = [{name: "n1", phone: "p1"},
  			   {name: "n2", phone: "p2"},
  			   {name: "n3", phone: "p3"}]
	bic = BatchImportCustomers.call(campaign, records).result 
	bsms = BatchSetSmsStatus.call(campaign).result
	assert CampaignCustomer.pluck(:sms_status), [true, true, true]
  end
end
