require 'test_helper'

class CampaignCostReportQueryTest < ActiveSupport::TestCase
  test "correct" do 
  	campaign_customers
  	query = CampaignCostReportQuery.new
  	assert query.render, [{:campaign_id=>1, :campaign_name=>"campaign 1", :total=>100.0, :customers_count=>2}]
  end
end