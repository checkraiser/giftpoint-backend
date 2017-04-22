require 'test_helper'

class CampaignTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "create campaign" do 
  	time = Time.current
  	campaign = CreateCampaign.call("campaign 1", "content", time, time + 1.month, "Hai Phong", 10, product).result
  	assert Campaign.all, [campaign]
  	assert time, campaign.start_time
  end

  test "failing create" do 
  	time = Time.current
  	campaign = CreateCampaign.call(nil, "content", time, time.ago(1.month), nil, 10, product)
  	assert campaign.errors, {:name=>["can't be blank"], :end_time=>["end_time must be after start_time"]}
  end
end
