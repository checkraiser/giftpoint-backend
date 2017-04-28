require 'test_helper'

class CampaignProductsQueryTest < ActiveSupport::TestCase
  test "correct" do 
  	campaign_customers
  	query = CampaignProductsQuery.new(campaign.name)
  	assert query.render.length, 2
  end
end