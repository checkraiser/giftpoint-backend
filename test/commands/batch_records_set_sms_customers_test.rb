require 'test_helper'

class BatchRecordsSetSmsCustomersTest < ActiveSupport::TestCase
	test "success" do 
		records = [{phone: "01214115322"}]
		command = BatchRecordsSetSmsCustomers.call(approved_campaign_customers, records)
		assert CampaignCustomer.pluck(:sms_status), [true, true]
	end
end