require 'test_helper'

class CustomerSearchQueryTest < ActiveSupport::TestCase
  test "by campaign" do 
  	campaign_customers
  	query = CustomerSearchQuery.new(campaign.id)
  	assert query.render.length, 2
  end
end