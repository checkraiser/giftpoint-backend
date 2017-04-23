require 'test_helper'

class SetSmsStatusTest < ActiveSupport::TestCase
  test "success set status" do   	
  	sms = SetSmsStatus.call(campaign_customer).result
  	assert sms.sms_status, true
  end

  test "batch set" do 
	 bsms = BatchSetSmsStatus.call(campaign_customers).result
	 assert CampaignCustomer.pluck(:sms_status), [true, true, true]
  end
end
