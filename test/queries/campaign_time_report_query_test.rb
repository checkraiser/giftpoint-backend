require 'test_helper'

class CampaignTimeReportQueryTest < ActiveSupport::TestCase
  test "correct" do 
  	campaign_customers
  	query = CampaignTimeReportQuery.new
  	assert query.render, [{:campaign_id=>1, :month=>4.0, :customer_count=>2, :product_name=>"product 1", :product_count=>2}]
  end
end