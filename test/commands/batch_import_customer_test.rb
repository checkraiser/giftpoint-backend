require 'test_helper'

class BatchImportCustomerTest < ActiveSupport::TestCase
  test "success import" do 
  	records = [{name: "n1", phone: "p1"},
  			   {name: "n2", phone: "p2"},
  			   {name: "n3", phone: "p3"}]
	  bic = BatchImportCustomers.call(campaign, records)  			   
	  assert CampaignCustomer.all, [bic.result]
	  assert CampaignCustomer.count, 3
  end

  test "partially failed import" do 
  	records = [{name: "n1", phone: "p1"},
  			   {name: "n2", phone: "p1"},
  			   {name: "n3", phone: "p3"}]
  	bic = BatchImportCustomers.call(campaign, records)  			   
  	assert CampaignCustomer.all, [bic.result]
  	assert CampaignCustomer.count, 2  			   
  end
end
