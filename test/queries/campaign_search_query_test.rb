require 'test_helper'

class CampaignSearchQueryTest < ActiveSupport::TestCase
  test "by city" do 
    campaign
    query = CampaignSearchQuery.new(nil,"Hai Phong", nil)
    assert query.render[0][:id], campaign.id
  end

  test "by date" do 
  	campaign
  	query = CampaignSearchQuery.new("2017-04-30",nil, nil)
  	assert query.render[0][:id], campaign.id
  end

  test "by product name" do 
  	campaign
  	query = CampaignSearchQuery.new(nil,nil, "product 1")
  	assert query.render[0][:id], campaign.id
  end

  test "search all" do 
  	campaign
  	query = CampaignSearchQuery.new(nil,nil, "product 1")
  	assert query.render[0][:id], campaign.id
  end
end
