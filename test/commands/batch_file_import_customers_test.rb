require 'test_helper'

class BatchFileImportCustomersTest < ActiveSupport::TestCase
  test "success " do 
  	command = BatchFileImportCustomers.call(campaign, customers_file)
  	assert command.result, CampaignCustomer.all
  end
end
